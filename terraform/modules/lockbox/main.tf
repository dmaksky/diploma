resource "yandex_lockbox_secret" "this" {
  name                = var.name
  description         = var.description
  folder_id           = var.folder_id
  kms_key_id          = var.kms_key_id
  deletion_protection = var.deletion_protection
  labels              = var.labels
}
