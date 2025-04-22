module "terraform_sa" {
  source       = "../../modules/service-account"
  name         = local.service_account_name
  description  = "Service account for Terraform"
  folder_id    = var.folder_id
  folder_role  = "editor"
}

module "kms" {
  source      = "../../modules/kms"
  name        = local.kms_key_name
  description = "CMK для шифрования состояния Terraform"
  labels      = local.labels
}

module "tfstate_bucket" {
  source                = "../../modules/s3"
  name                  = local.bucket_name
  kms_key_id            = module.kms.id
  folder_id             = var.folder_id
  versioning_enabled    = true
  default_storage_class = "STANDARD"
  labels                = local.labels
}
