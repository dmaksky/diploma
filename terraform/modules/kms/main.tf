resource "yandex_kms_symmetric_key" "this" {
  name              = var.name
  description       = var.description
  rotation_period   = var.rotation_period
  labels            = var.labels
  default_algorithm = "AES_256"
}
