locals {
  network_name = "${local.prefix}-vpc"
  rt_name      = "${local.prefix}-nat-rt"
  nat_name     = "${local.prefix}-nat"

  labels = {
    project     = var.project_name
    environment = terraform.workspace
    stage       = "10-network"
  }
}
