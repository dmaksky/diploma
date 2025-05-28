module "network" {
  source               = "../../modules/network"
  network_name         = local.network_name
  folder_id            = var.folder_id
  zones                = var.zones
  subnet_cidrs         = var.subnet_cidrs
  nat_name             = local.nat_name
  rt_name              = local.rt_name
  labels               = local.labels
}

module "mgmt_sg" {
  source        = "../../modules/security-group"
  name          = "${local.prefix}-mgmt-sg"
  network_id    = module.network.network_id
  labels        = local.labels

  ingress_rules = [{
    protocol       = "TCP"
    description    = "SSH"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }]
  egress_rules = [{
    description    = "Доступ куда угодно"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }]
}

module "k8s_main_sg" {
  source        = "../../modules/security-group"
  name          = "${local.prefix}-main-sg"
  network_id    = module.network.network_id
  labels        = local.labels

  ingress_rules = [{
    description       = "The rule allows availability checks from the load balancer's range of addresses. It is required for the operation of a fault-tolerant cluster and load balancer services."
    protocol          = "TCP"
    v4_cidr_blocks    = ["198.18.235.0/24", "198.18.248.0/24"]
    from_port         = 0
    to_port           = 65535
  },
  {
    description       = "The rule allows the master-node and node-node interaction within the security group"
    protocol          = "ANY"
    predefined_target = "self_security_group"
    from_port         = 0
    to_port           = 65535
  },
  {
    description    = "The rule allows the pod-pod and service-service interaction. Specify the subnets of your cluster and services."
    protocol       = "ANY"
    v4_cidr_blocks = var.subnet_cidrs
    from_port      = 0
    to_port        = 65535
  },
  {
    description    = "The rule allows receipt of debugging ICMP packets from internal subnets"
    protocol       = "ICMP"
    v4_cidr_blocks = var.subnet_cidrs
  },
  {
    description       = "The rule allows connection to Kubernetes API on 6443 port from mgmt host"
    protocol          = "TCP"
    port              = 6443
    security_group_id = module.mgmt_sg.id
  },
  {
    description       = "The rule allows connection to Kubernetes API on 443 port from mgmg host"
    protocol          = "TCP"
    port              = 443
    security_group_id = module.mgmt_sg.id
  },
  {
    description       = "The rule allows connection by SSH on 22 port from the mgmt host"
    protocol          = "TCP"
    port              = 22
    security_group_id = module.mgmt_sg.id
  },
  {
    description       = "The rule allows HTTP traffic"
    protocol          = "TCP"
    port              = 80
    security_group_id = module.mgmt_sg.id
  },
  {
    description    = "The rule allows connection to Yandex Container Registry on 5050 port"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 5050
  }]

  egress_rules = [{
    description    = "The rule allows all outgoing traffic. Nodes can connect to Yandex Container Registry, Object Storage, Docker Hub, and more."
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }]
}

module "k8s_public_services_sg" {
  source        = "../../modules/security-group"
  name          = "${local.prefix}-public-sg"
  network_id    = module.network.network_id
  labels        = local.labels

  ingress_rules = [{
    description    = "The rule allows incoming traffic from the internet to the NodePort port range. Add ports or change existing ones to the required ports."
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 30000
    to_port        = 32767
  }]
}
