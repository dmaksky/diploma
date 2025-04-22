resource "yandex_storage_bucket" "this" {
  bucket                = var.name
  folder_id             = var.folder_id
  default_storage_class = var.default_storage_class
  max_size              = var.max_size
  acl                   = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.kms_key_id
        sse_algorithm     = "aws:kms"
      }
    }
  }

  versioning {
    enabled = var.versioning_enabled
  }

  tags = var.labels
}
