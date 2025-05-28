output "network_id" {
  value       = module.network.network_id
  description = "ID VPC"
}

output "subnet_ids" {
  value       = module.network.subnet_ids
  description = "IDs подсетей"
}

output "nat_gateway_ids" {
  value       = module.network.nat_id
  description = "ID NAT-шлюза"
}

output "security_group_ids" {
  value = {
    mgmt                = module.mgmt_sg.id
    k8s_main            = module.k8s_main_sg.id
    k8s_public_services = module.k8s_public_services_sg.id
  }
  description = "IDs всех SG"
}

output "k8s-ext-address" {
  value       = module.network.k8s-ext-address 
  description = "Внешний адрес для кластера"
}

