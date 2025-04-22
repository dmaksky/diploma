resource "yandex_vpc_network" "this" {
  name      = var.network_name
  folder_id = var.folder_id
  labels    = var.labels
}

resource "yandex_vpc_subnet" "private" {
  for_each = zipmap(var.zones, var.private_subnet_cidrs)

  name            = "${var.network_name}-private-${each.key}"
  zone            = each.key
  network_id      = yandex_vpc_network.this.id
  v4_cidr_blocks  = [each.value]
  labels          = var.labels
  route_table_id  = yandex_vpc_route_table.this.id
}

resource "yandex_vpc_subnet" "public" {
  for_each = zipmap(var.zones, var.public_subnet_cidrs)

  name           = "${var.network_name}-public-${each.key}"
  zone           = each.key
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = [each.value]
  labels         = var.labels
}
resource "yandex_vpc_route_table" "this" {
  folder_id      = var.folder_id
  name           = var.rt_name
  description    = "Маршрут в интернет для NAT шлюза"
  network_id     = yandex_vpc_network.this.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = var.gateway_id
  }
}
