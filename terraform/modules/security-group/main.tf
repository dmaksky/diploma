resource "yandex_vpc_security_group" "this" {
  name        = var.name
  description = var.name
  labels      = var.labels
  network_id  = var.network_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      protocol          = ingress.value.protocol
      description       = ingress.value.description
      from_port         = try(ingress.value.from_port, null)
      to_port           = try(ingress.value.to_port, null)
      port              = try(ingress.value.port, null)
      v4_cidr_blocks    = try(ingress.value.v4_cidr_blocks, null)
      security_group_id = try(ingress.value.security_group_id, null)
      predefined_target = try(ingress.value.predefined_target, null)
    }
  }

  egress {
    description    = "Permit ANY"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
