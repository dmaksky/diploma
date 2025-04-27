module "nat" {
  source    = "../../modules/nat"
  name      = local.nat_name
  folder_id = var.folder_id
  labels    = local.labels
}

module "network" {
  source               = "../../modules/network"
  network_name         = local.network_name
  folder_id            = var.folder_id
  zones                = var.zones
  private_subnet_cidrs = [for subnet in var.subnets : subnet.private_cidr ]
  public_subnet_cidrs  = [for subnet in var.subnets : subnet.public_cidr ]
  gateway_id           = module.nat.id
  rt_name              = local.rt_name
  labels               = local.labels
}

module "sg_public_bastion" {
  source        = "../../modules/security-group"
  name          = "${local.prefix}-sg-public-bastion"
  network_id    = module.network.id
  labels        = local.labels

  ingress_rules = [{
    protocol       = "TCP"
    description    = "SSH"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }]
}

module "sg_private_bastion" {
  source        = "../../modules/security-group"
  name          = "${local.prefix}-sg-private-bastion"
  network_id    = module.network.id
  labels        = local.labels

  egress_rules = [{
    protocol          = "TCP"
    description       = "SSH"
    port              = 22
    predefined_target = "self_security_group"
  }]

  ingress_rules = [{
    protocol          = "TCP"
    description       = "SSH"
    port              = 22
    v4_cidr_blocks    = [cidrsubnet(var.subnets[var.zone].private_cidr, 8, 254)]
  }]
}

module "sg_k8s_control" {
  source        = "../../modules/security-group"
  name          = "${local.prefix}-sg-k8s-control"
  network_id    = module.network.id
  labels        = local.labels

  ingress_rules = [
    {
      protocol          = "TCP"
      description       = "k8s API"
      port              = 6443
      predefined_target = "self_security_group"
    },
    {
      protocol          = "TCP"
      description       = "etcd communication"
      from_port         = 2379
      to_port           = 2380
      predefined_target = "self_security_group"
    }
  ]
  egress_rules = [
    {
      protocol       = "ANY"
      description    = "ALL out"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "sg_k8s_worker" {
  source        = "../../modules/security-group"
  name          = "${local.prefix}-sg-k8s-worker"
  network_id    = module.network.id
  labels        = local.labels

  ingress_rules = [
    {
      protocol          = "TCP"
      description       = "kubelet"
      port              = 10250
      predefined_target = "self_security_group"
    },
    {
      protocol          = "TCP"
      description       = "Node Port трафик"
      from_port         = 30000
      to_port           = 32767
      predefined_target = "self_security_group"
    }
  ]
  egress_rules = [
    {
      protocol       = "ANY"
      description    = "ALL out"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

module "sg_nlb_api" {
  source        = "../../modules/security-group"
  name          = "${local.prefix}-sg-nlb-api"
  network_id    = module.network.id
  labels        = local.labels

  ingress_rules = [
    {
      protocol       = "TCP"
      description    = "NLB"
      port           = 6443
      v4_cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  egress_rules = [
    {
      protocol       = "ANY"
      description    = "ALL out"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
