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

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      protocol          = egress.value.protocol
      description       = egress.value.description
      from_port         = try(egress.value.from_port, null)
      to_port           = try(egress.value.to_port, null)
      port              = try(egress.value.port, null)
      v4_cidr_blocks    = try(egress.value.v4_cidr_blocks, null)
      security_group_id = try(egress.value.security_group_id, null)
      predefined_target = try(egress.value.predefined_target, null)
    }
  }
}
