output "network_id"  { value = yandex_vpc_network.network.id }
output "subnet_ids"  {
  value = { for k, v in yandex_vpc_subnet.subnet : k => v.id }
}

output "sg_id" {
  description = "ID созданных security‑groups"
  value = yandex_vpc_security_group.sg.id 
}
