output "secret_id" {
  description = "ID Lockbox-секрета"
  value       = yandex_lockbox_secret.this.id
}

output "version_id" {
  description = "ID версии секрета"
  value       = yandex_lockbox_secret_version_hashed.this.id
}
