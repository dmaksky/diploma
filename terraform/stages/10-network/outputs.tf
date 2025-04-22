output "network_id"  { value = module.vpc.network_id }
output "subnet_ids"  { value = module.vpc.subnet_ids }

output "sg_id" {
  value = module.vpc.sg_id
}
