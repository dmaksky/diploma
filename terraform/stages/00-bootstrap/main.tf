resource "yandex_iam_service_account" "tf_sa" {
  name        = "${local.project}-tf-sa"
  description = "Сервисный аккаунт YC для terraform"
}

resource "yandex_iam_service_account_static_access_key" "tf_sa_key" {
  service_account_id = yandex_iam_service_account.tf_sa.id
  description        = "Статический ключ сервисного аккаунта для доступа к бакету"
}

resource "yandex_resourcemanager_folder_iam_member" "sa_editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.tf_sa.id}"
}

resource "random_id" "suffix" {
  byte_length = 4
  keepers = { 
    env     = var.env 
    project = local.project
    stage   = local.stage
  }
}

resource "yandex_kms_symmetric_key" "cmk" {
  name              = "cmk-${var.env}"
  description       = "Ключ шифрования для логов, бэкапов и дисков"
  default_algorithm = "AES_256"
  rotation_period   = "8760h"

  labels = {
    env     = var.env
    project = local.project
    stage   = local.stage
  }
}

resource "yandex_storage_bucket" "tfstate" {
  bucket      = "tfstate-${var.env}-${random_id.suffix.hex}"
  folder_id   = var.folder_id
  acl         = "private"
  max_size    = 1024 * 1024 * 1024

  versioning {
    enabled = var.bucket_versioning
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.cmk.id
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = {
    env     = var.env
    project = local.project
    stage   = local.stage
  }
}
