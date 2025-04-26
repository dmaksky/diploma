resource "yandex_compute_disk" "this" {
  name             = var.name
  folder_id        = var.folder_id
  zone             = var.zone
  size             = var.size
  type             = var.type
  image_id         = var.image_id
  kms_key_id       = var.kms_key_id
  labels           = var.labels
}
