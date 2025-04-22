resource "yandex_lockbox_secret" "this" {
  name                = var.name
  description         = var.description
  folder_id           = var.folder_id
  kms_key_id          = var.kms_key_id
  deletion_protection = var.deletion_protection
  labels              = var.labels
}

resource "yandex_lockbox_secret_version_hashed" "this" {
  secret_id    = yandex_lockbox_secret.this.id
  
  key_1        = var.secret_key
  text_value_1 = var.secret_value
}
