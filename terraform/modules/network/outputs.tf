output "network_id" {
  value       = yandex_vpc_network.this.id
  description = "ID VPC сети"
}

output "subnet_ids" {
  value       = [for s in yandex_vpc_subnet.this : s.id]
  description = "IDs подсетей"
}

output "nat_id" {
  value       = yandex_vpc_gateway.this.id
  description = "ID NAT-шлюза"
}

output "k8s-ext-address" {
  value       = yandex_vpc_address.this.external_ipv4_address[0].address
  description = "Внешний адрес для кластера"
}
