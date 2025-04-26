locals {
  kms_key_name         = "${local.prefix}-tfstate-key"
  terraform_sa_name    = "${local.prefix}-terraform-sa" 
  ansible_sa_name      = "${local.prefix}-ansible-sa" 
  bucket_name          = "${local.prefix}-tfstate-bucket"
  labels               = {
    project     = var.project_name
    stage       = "00-bootstrap"
    environment = terraform.workspace
  }
}
