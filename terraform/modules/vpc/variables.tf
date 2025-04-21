variable "network_name" { type = string }
variable "labels"       { type = map(string) }
variable "subnets" {
  type = map(object({
    name = string
    zone = string
    cidr = string
  }))
}

variable "admin_cidrs" {
  description = "CIDR, откуда разрешён административный доступ (SSH)."
  type        = list(string)
}
