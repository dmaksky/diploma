output "id" {
  value       = yandex_vpc_network.this.id
  description = "ID VPC сети"
}

output "private_subnet_ids_list" {
  value       = [for s in yandex_vpc_subnet.private : s.id]
  description = "IDs private-подсетей в порядке zones"
}

output "public_subnet_ids_list" {
  value       = [for s in yandex_vpc_subnet.public : s.id]
  description = "IDs public-подсетей в порядке zones"
}
