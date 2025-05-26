module "terraform_sa" {
  source       = "../../modules/service-account"
  name         = local.terraform_sa_name
  description  = "Сервисный аккаунт для terraform"
  folder_id    = var.folder_id
  roles        = ["admin"]
}

module "kms" {
  source      = "../../modules/kms"
  name        = local.kms_key_name
  description = "CMK для шифрования состояния Terraform"
  labels      = local.labels
}

module "tfstate_s3" {
  source                = "../../modules/s3"
  name                  = local.bucket_name
  kms_key_id            = module.kms.id
  folder_id             = var.folder_id
  versioning_enabled    = true
  lifecycle_enabled     = false
  default_storage_class = "STANDARD"
  labels                = local.labels
}

module "oslogin" {
  source          = "../../modules/oslogin"
  organization_id = var.organization_id
}
