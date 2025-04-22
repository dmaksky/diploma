output "network_id" {
  value       = module.network.id
  description = "ID VPC"
}

output "private_subnet_ids" {
  value       = module.network.private_subnet_ids_list
  description = "IDs private-подсетей"
}

output "public_subnet_ids" {
  value       = module.network.public_subnet_ids_list
  description = "IDs public-подсетей"
}

output "nat_gateway_ids" {
  value       = module.nat.id
  description = "ID NAT-шлюза"
}

output "security_group_ids" {
  value = {
    bastion     = module.sg_bastion.id
    k8s_control = module.sg_k8s_control.id
    k8s_worker  = module.sg_k8s_worker.id
    nlb_api     = module.sg_nlb_api.id
  }
  description = "IDs всех SG"
}
