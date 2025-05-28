resource "yandex_container_registry" "this" {
  name      = var.name
  folder_id = var.folder_id
}
