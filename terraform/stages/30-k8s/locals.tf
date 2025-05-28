locals {
  network_id          = data.terraform_remote_state.network.outputs.network_id
  subnets_ids         = data.terraform_remote_state.network.outputs.subnet_ids
  security_group_ids  = data.terraform_remote_state.network.outputs.security_group_ids
  bucket_name         = data.terraform_remote_state.bootstrap.outputs.tfstate_bucket
  k8s-ext-address     = data.terraform_remote_state.network.outputs.k8s-ext-address
  
  k8s_sa_name     = "${local.prefix}-k8s-sa"
  registry_name   = "${local.prefix}-registry"
  pg_bucket_name  = "${local.prefix}-pg-backup-s3"
  secrets_name    = "${local.prefix}-secrets"
  cluster_name    = "${local.prefix}-k8s-cluster"
  obs_name        = "${local.prefix}-obs-k8s-nodes"
  pg_name         = "${local.prefix}-pg-k8s-nodes"
  kms_key_id      = data.terraform_remote_state.bootstrap.outputs.kms_key_id

  labels = {
    project     = var.project_name
    environment = terraform.workspace
    stage       = "30-k8s"
  }
}
