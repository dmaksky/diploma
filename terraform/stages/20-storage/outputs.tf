output "registry_id" {
  description = "ID Container Registry"
  value       = module.registry.id
}

output "pg_backup_bucket_name" {
  description = "Имя S3-бакета для pg-бэкапов"
  value       = module.pg_backup_bucket.name
}

output "lockbox_pg_secret_id" {
  description = "ID Lockbox секрета для pg"
  value       = module.lockbox_pg_secrets.secret_id
}

output "lockbox_pg_version_id" {
  description = "ID версии Lockbox секрета для pg"
  value       = module.lockbox_pg_secrets.version_id
}

output "loki_bucket_name" {
  description = "Имя S3-бакета для логов Loki"
  value       = module.loki_bucket.name
}

output "lockbox_loki_secret_id" {
  description = "ID Lockbox секрета для Loki S3 creds"
  value       = module.lockbox_loki_secrets.secret_id
}

output "lockbox_loki_version_id" {
  description = "ID версии Lockbox секрета для Loki creds"
  value       = module.lockbox_loki_secrets.version_id
}
