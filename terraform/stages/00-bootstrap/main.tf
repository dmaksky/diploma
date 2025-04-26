module "terraform_sa" {
  source       = "../../modules/service-account"
  name         = local.terraform_sa_name
  description  = "Service account for Terraform"
  folder_id    = var.folder_id
  folder_role  = "admin"
}

module "ansible_sa" {
  source       = "../../modules/service-account"
  name         = local.ansible_sa_name
  description  = "Service account for Ansbile"
  folder_id    = var.folder_id
  folder_role  = "compute.osLogin"
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

module "oslogin" {
  source          = "../../modules/oslogin"
  organization_id = var.organization_id
}
