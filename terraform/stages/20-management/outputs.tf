output "mgmt_id" {
  description = "ID management хоста"
  value       = module.mgmt.id
}

output "mgmt_public_ip" {
  description = "публичный ip management хоста"
  value       = module.mgmt.external_ips
}

output "ansible_sa_name" {
  description = "Имя сервисного аккаунта Ansible"
  value       = module.ansible_sa.name
}
