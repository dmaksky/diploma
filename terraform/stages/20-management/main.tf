module "ansible_sa" {
  source       = "../../modules/service-account"
  name         = local.ansible_sa_name
  description  = "Service account for Ansbile"
  folder_id    = var.folder_id
  roles        = ["compute.osAdminLogin"]
}

module "mgmt" {
  source              = "../../modules/instance"
  name                = local.mgmt_name
  folder_id           = var.folder_id
  zone                = var.zone
  network_interfaces  = [
    {
      subnet_id          = local.subnet_ids[1]
      security_group_ids = [local.security_group_ids["mgmt"]]
      ipv4_address       = cidrhost(var.subnet_cidrs[1], 254)
      nat                = true
    }
  ]
  service_account_id  = module.ansible_sa.id
  image_id            = var.image_id
  key_id              = local.kms_key_id
  cores               = var.mgmt_cores
  memory              = var.mgmt_memory
  labels              = merge(local.labels,{ role="mgmt" })
}
