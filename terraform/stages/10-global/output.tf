output "kms_key_id" {
  description = "ID симметричного ключа KMS"
  value       = yandex_kms_symmetric_key.cmk.id
}

output "container_registry_id" {
  description = "ID YC Container Registry"
  value       = yandex_container_registry.cr.id
}

output "logs_group_id" {
  description = "ID группы логов для инфраструктуры"
  value       = yandex_logging_group.logs.id
}


output "audit_trail_id" {
  description = "ID аудит трейла"
  value       = yandex_audit_trails_trail.basic_trail.id
}
