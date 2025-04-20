resource "yandex_iam_service_account" "tf_sa" {
  name        = "${local.project}-tf-sa"
  description = "Сервисный аккаунт YC для terraform"
}

resource "yandex_iam_service_account_static_access_key" "tf_sa_key" {
  service_account_id = yandex_iam_service_account.tf_sa.id
  description        = "Статический ключ сервисного аккаунта для доступа к бакету"
}

resource "yandex_resourcemanager_folder_iam_member" "sa_storage_admin" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.tf_sa.id}"
}

resource "random_id" "suffix" {
  byte_length = 4
  keepers = { env = var.env }
}

resource "yandex_storage_bucket" "tfstate" {
  bucket    = "tfstate-${var.env}-${random_id.suffix.hex}"
  folder_id = var.folder_id
  acl       = "private"
  max_size  = 1073741824

  force_destroy = var.force_destroy

  versioning {
    enabled = var.bucket_versioning
  }
}
