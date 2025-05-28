locals {
  network_id          = data.terraform_remote_state.network.outputs.network_id
  subnet_ids          = data.terraform_remote_state.network.outputs.subnet_ids
  security_group_ids  = data.terraform_remote_state.network.outputs.security_group_ids
  bucket_name         = data.terraform_remote_state.bootstrap.outputs.tfstate_bucket

  mgmt_name       = "${local.prefix}-mgmt"
  kms_key_id      = data.terraform_remote_state.bootstrap.outputs.kms_key_id
  ansible_sa_name = "${local.prefix}-ansible-sa"

  labels = {
    project     = var.project_name
    environment = terraform.workspace
    stage       = "20-management"
  }
}
