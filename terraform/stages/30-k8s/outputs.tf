output "cluster_name" {
  description = "Имя кластера"
  value       = local.cluster_name 
}

output "lockbox_secret_id" {
  description = "ID lockbox секрета"
  value       = module.lockbox_secrets.secret_id
}

output "pg_access_key" {
  value       = module.k8s_sa.sa_access_key
  sensitive   = true
  description = "Ключ доступа: сохраните в безопасном месте!"
}

output "pg_secret_key" {
  value       = module.k8s_sa.sa_secret_key
  sensitive   = true
  description = "Секретный ключ: сохраните в безопасном месте!"
}

output "pg_bucket" {
  description = "Имя бакета для бэкапов"
  value       = module.pg_backup_bucket.name
}

