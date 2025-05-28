module "k8s_sa" {
  source       = "../../modules/service-account"
  name         = local.k8s_sa_name
  description  = "Service account for k8s"
  folder_id    = var.folder_id
  roles        = ["admin"]
}

module "registry" {
  source    = "../../modules/registry"
  name      = local.registry_name
  folder_id = var.folder_id
}

module "pg_backup_bucket" {
  source                = "../../modules/s3"
  name                  = local.pg_bucket_name
  default_storage_class = "COLD"
  kms_key_id            = data.terraform_remote_state.bootstrap.outputs.kms_key_id
  max_size              = 0
  folder_id             = var.folder_id
  labels                = merge(local.labels, {"role" = "pg_backup"})
}

module "lockbox_secrets" {
  source       = "../../modules/lockbox"
  name         = local.secrets_name
  folder_id    = var.folder_id
  description  = "Секреты: пароли, ключи для доступа в бакет и т.д."
  kms_key_id   = data.terraform_remote_state.bootstrap.outputs.kms_key_id
  labels       = merge(local.labels, {"role" = "secrets_storage"})
}

module "k8s" {
  source = "../../modules/k8s"

  cluster_name       = local.cluster_name
  network_id         = local.network_id
  zones              = var.zones
  subnets_ids        = local.subnets_ids
  security_group_ids = local.security_group_ids
  k8s_sa_id          = module.k8s_sa.id
  k8s_version        = var.k8s_version
  labels             = local.labels

  obs_group_name      = local.obs_name
  obs_group_size      = var.obs_size
  obs_group_platform  = var.obs_platform
  obs_group_memory    = var.obs_memory
  obs_group_cores     = var.obs_cores
  obs_group_disk_type = var.obs_disk_type
  obs_group_disk_size = var.obs_disk_size 

  pg_group_name       = local.pg_name
  pg_group_size       = var.pg_size
  #pg_init_size        = var.pg_init_size
  #pg_min_size         = var.pg_min_size
  #pg_max_size         = var.pg_max_size
  pg_group_platform   = var.pg_platform
  pg_group_memory     = var.pg_memory
  pg_group_cores      = var.pg_cores
  pg_group_disk_type  = var.pg_disk_type
  pg_group_disk_size  = var.pg_disk_size
}
