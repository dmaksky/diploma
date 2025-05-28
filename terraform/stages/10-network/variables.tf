variable "subnet_cidrs" {
  description = "CIDR для подсетей, в том же порядке, что и zones"
  type        = list(string)
}

variable "zones" {
  description = "Список зон доступности"
  type        = list(string)
}
