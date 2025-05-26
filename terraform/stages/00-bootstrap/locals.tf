locals {
  kms_key_name         = "${local.prefix}-key"
  terraform_sa_name    = "${local.prefix}-terraform-sa" 
  bucket_name          = "${local.prefix}-tfstate-s3"
  labels               = {
    project     = var.project_name
    stage       = "00-bootstrap"
    environment = terraform.workspace
  }
}
