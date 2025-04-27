variable "private_subnet_cidrs" {
  description = "CIDR для private-подсетей, в том же порядке, что и zones"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR для public-пodcетей (DMZ), в том же порядке"
  type        = list(string)
}

variable "subnets" {
  description = "Публичные и приватные подсети в каждой из зон"
  type        = map(object({
    private_cidr = string
    public_cidr  = string
  }))
}

variable "zones" {
  description = "Список зон доступности"
  type        = list(string)
}
