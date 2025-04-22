variable "name" {
  description = "Имя Security Group"
  type        = string
}

variable "network_id" {
  description = "ID облачной сети"
  type        = string
}

variable "labels" {
  description = "Теги для SG"
  type        = map(string)
}

variable "ingress_rules" {
  description = "Список правил ingress"
  type = list(object({
    protocol            = string
    description         = string
    from_port           = optional(number)
    to_port             = optional(number)
    port                = optional(number)
    v4_cidr_blocks      = optional(list(string))
    security_group_id   = optional(string)
    predefined_target   = optional(string)
  }))
}
