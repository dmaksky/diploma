resource "yandex_vpc_network" "network" {
  name   = var.network_name
  labels = var.labels
}

resource "yandex_vpc_subnet" "subnet" {
  for_each       = var.subnets
  name           = each.value.name
  zone           = each.value.zone
  v4_cidr_blocks = [each.value.cidr]
  network_id     = yandex_vpc_network.network.id
  labels         = var.labels
}

resource "yandex_vpc_security_group" "sg" {
  name       = "sg-${var.labels.env}"
  network_id = yandex_vpc_network.network.id
  labels     = var.labels

  # egress — полностью открыт (частая практика)
  egress {
    protocol          = "ANY"
    description       = "Outbound any"
    v4_cidr_blocks    = ["0.0.0.0/0"]
    from_port         = 0
    to_port           = 65535
  }

  ingress {
    protocol          = "ANY"
    description       = "Разрешает взаимодействие между ресурсами текущей группы безопасности"
    predefined_target = "self_security_group"
    from_port         = 0
    to_port           = 65535
  }

  # inbound: SSH для админов
  dynamic "ingress" {
    for_each = var.admin_cidrs
    content {
      protocol       = "TCP"
      description    = "SSH from admin CIDR ${ingress.value}"
      port           = 22
      v4_cidr_blocks = [ingress.value]
    }
  }
}
