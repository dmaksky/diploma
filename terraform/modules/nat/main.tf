resource "yandex_vpc_gateway" "this" {
  name      = var.name
  folder_id = var.folder_id
  labels    = var.labels

  shared_egress_gateway {}
}
