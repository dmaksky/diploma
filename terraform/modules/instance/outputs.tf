output "id" {
  description = "Instance ID"
  value       = yandex_compute_instance.this.id
}
output "internal_ips" {
  description = "Внутренние IP адреса инстансов"
  value       = [ for interface in yandex_compute_instance.this.network_interface : interface.ip_address if ! interface.nat ]
}

output "external_ips" {
  description = "Внешние IP адреса инстансов"
  value       = [ for interface in yandex_compute_instance.this.network_interface : interface.nat_ip_address if interface.nat ]
}
