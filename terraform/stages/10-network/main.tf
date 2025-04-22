module "vpc" {
  source = "../../modules/vpc"

  network_name      = var.network_name
  subnets           = var.subnets
  admin_cidrs       = var.admin_cidrs

  labels = {
    project = local.project
    stage   = local.stage
    env     = var.env
  }
}
