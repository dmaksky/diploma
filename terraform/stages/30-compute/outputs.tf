output "master_internal_ips" {
  description = "Статические внутренние IP мастеров"
  value       = { for z, m in module.master : z => m.internal_ips }
}

output "master_ids" {
  description = "IDs мастеров"
  value       = [for m in module.master : m.id]
}

output "workers_ig_id" {
  description = "ID Instance Group воркеров"
  value       = module.workers.id
}

output "bastion_public_ip" {
  description = "Публичный IP бастиона"
  value       = module.bastion.external_ips
}
