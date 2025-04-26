locals {
  network_id          = data.terraform_remote_state.network.outputs.network_id
  private_subnet_ids  = data.terraform_remote_state.network.outputs.private_subnet_ids
  public_subnet_ids   = data.terraform_remote_state.network.outputs.public_subnet_ids
  security_group_ids  = data.terraform_remote_state.network.outputs.security_group_ids
  bucket_name         = data.terraform_remote_state.bootstrap.outputs.tfstate_bucket_name
  
  bastion_name    = "${local.prefix}-bastion"
  workers_ig_name = "${local.prefix}-worker-ig"
  kms_key_id      = data.terraform_remote_state.bootstrap.outputs.kms_key_id
  k8s_nodes_sa_id = data.terraform_remote_state.bootstrap.outputs.terraform_sa_id
  bastion_sa_id   = data.terraform_remote_state.bootstrap.outputs.terraform_sa_id

  labels = {
    project     = var.project_name
    environment = terraform.workspace
    stage       = "30-compute"
  }
}
