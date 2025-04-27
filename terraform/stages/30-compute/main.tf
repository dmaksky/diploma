module "etcd_disk" {
  for_each   = toset(var.zones)
  source     = "../../modules/disk"
  name       = "${local.prefix}-etcd-${each.key}"
  folder_id  = var.folder_id
  zone       = each.key
  size       = var.master_data_size
  kms_key_id = local.kms_key_id
  labels     = merge(local.labels,{ role="etcd", subject="master" })
}

module "master_boot_disk" {
  for_each   = toset(var.zones)
  source     = "../../modules/disk"
  name       = "${local.prefix}-master_boot-${each.key}"
  folder_id  = var.folder_id
  zone       = each.key
  size       = var.master_root_size
  kms_key_id = local.kms_key_id
  labels     = merge(local.labels,{ role="boot", subject="master" })
}

module "bastion_boot_disk" {
  source     = "../../modules/disk"
  name       = "${local.prefix}-bastion_boot"
  folder_id  = var.folder_id
  zone       = var.zone
  size       = var.bastion_root_size
  kms_key_id = local.kms_key_id
  labels     = merge(local.labels,{ role="boot", subject="bastion" })
}

module "master" {
  for_each            = toset(var.zones)
  source              = "../../modules/instance"
  name                = "${local.prefix}-master-${each.key}"
  folder_id           = var.folder_id
  zone                = each.key
  platform_id         = var.master_platform_id
  network_interfaces  = [{
    subnet_id          = local.private_subnet_ids[each.key]
    security_group_ids = [local.security_group_ids["k8s_control"]]
    nat                = false
  }]
  boot_disk_id        = module.master_boot_disk[each.key].id
  service_account_id  = local.k8s_nodes_sa_id
  cores               = var.master_cores
  memory              = var.master_memory
  additional_disk_ids = [module.etcd_disk[each.key].id]
  labels              = merge(local.labels,{ role="master" })
}

module "workers" {
  source             = "../../modules/instance-group"
  name               = local.workers_ig_name
  folder_id          = var.folder_id
  network_id         = local.network_id
  subnet_ids         = [for z in var.zones : local.private_subnet_ids[z]]
  zones              = var.zones
  platform_id        = var.worker_platform_id
  service_account_id = local.k8s_nodes_sa_id
  security_group_ids = [local.security_group_ids["k8s_worker"]]
  image_id           = var.image_id
  root_disk_size     = var.worker_root_size
  data_disk_size     = var.worker_data_size
  cores              = var.worker_cores
  memory             = var.worker_memory
  min_size           = var.worker_min
  max_size           = var.worker_max
  cpu_target         = var.worker_cpu_utilization
  memory_target      = var.worker_memory_target
  labels             = merge(local.labels,{ role="worker" })
}

module "bastion" {
  source              = "../../modules/instance"
  name                = local.bastion_name
  folder_id           = var.folder_id
  zone                = var.zone
  platform_id         = var.bastion_platform_id
  network_interfaces  = [
    {
      subnet_id          = local.private_subnet_ids[var.zone]
      security_group_ids = [local.security_group_ids["private_bastion"]]
      ipv4_address       = cidrhost(var.subnets[var.zone].private_cidr, 254)
      nat                = false
    },
    {
      subnet_id          = local.public_subnet_ids[var.zone]
      security_group_ids = [local.security_group_ids["public_bustion"]]
      nat                = true
    }
  ]
  boot_disk_id        = module.bastion_boot_disk.id
  service_account_id  = local.bastion_sa_id
  cores               = var.bastion_cores
  memory              = var.bastion_memory
  labels              = merge(local.labels,{ role="bastion" })
}
