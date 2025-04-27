output "id" {
  value       = yandex_vpc_network.this.id
  description = "ID VPC сети"
}

output "private_subnet_ids_map" {
  value       = {for s in yandex_vpc_subnet.private : s.zone => s.id}
  description = "IDs private-подсетей и соотвествующие зоны"
}

output "public_subnet_ids_map" {
  value       = {for s in yandex_vpc_subnet.public : s.zone => s.id}
  description = "IDs public-подсетей и соотвествующие зоны"
}
