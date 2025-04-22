module "registry" {
  source    = "../../modules/container-registry"
  name      = "${local.prefix}-registry"
  folder_id = var.folder_id
}

module "pg_backup_bucket" {
  source                = "../../modules/s3"
  name                  = local.pg_bucket_name
  default_storage_class = "COLD"
  kms_key_id            = data.terraform_remote_state.bootstrap.outputs.kms_key_id
  max_size              = 0
  folder_id             = var.folder_id
  labels                = local.labels
}

module "lockbox_pg_secrets" {
  source       = "../../modules/lockbox-secret"
  name         = local.pg_secrets_name
  folder_id    = var.folder_id
  description  = "Секреты для PG: пароли, ключи для доступа в бакет и т.д."
  kms_key_id   = data.terraform_remote_state.bootstrap.outputs.kms_key_id
  secret_key   = "something"
  secret_value = "else"
  labels       = local.labels
}

module "loki_bucket" {
  source                = "../../modules/s3"
  name                  = local.loki_bucket_name
  default_storage_class = "STANDARD"
  kms_key_id            = data.terraform_remote_state.bootstrap.outputs.kms_key_id
  max_size              = 0
  folder_id             = var.folder_id
  labels                = local.labels
}

module "lockbox_loki_secrets" {
  source       = "../../modules/lockbox-secret"
  name         = local.loki_secrets_name
  folder_id    = var.folder_id
  description  = "Секреты для Loki"
  kms_key_id   = data.terraform_remote_state.bootstrap.outputs.kms_key_id
  secret_key   = "something"
  secret_value = "else"
  labels       = local.labels
}
