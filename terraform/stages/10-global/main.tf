resource "yandex_kms_symmetric_key" "cmk" {
  name              = "cmk-${var.env}"
  description       = "Ключ шифрования для логов, бэкапов и дисков"
  default_algorithm = "AES_256"
  rotation_period   = "8760h"
  labels = {
    env = "${var.env}"
  }
}

resource "yandex_container_registry" "cr" {
  name        = "cr-${var.env}"
  folder_id   = var.folder_id
  labels = {
    env = "${var.env}"
  }
}

resource "yandex_logging_group" "logs" {
  name                  = "logs-${var.env}"
  retention_period      = "720h"
  folder_id             = var.folder_id
  description           = "Группа логгирования"
  labels = {
    env = "${var.env}"
  }
}

resource "yandex_audit_trails_trail" "basic_trail" {
  name        = "basic-trail-${var.env}"
  folder_id   = var.folder_id
  description = "Базовый трейл"
  labels = {
    env = "${var.env}" 
  }

  service_account_id = data.terraform_remote_state.bootstrap.outputs.sa_id

  logging_destination {
    log_group_id = yandex_logging_group.logs.id
  }

  filtering_policy {
    data_events_filter {
      service = "compute"
      resource_scope {
        resource_id   = var.folder_id
        resource_type = "resource-manager.folder"
      }
    }

    data_events_filter {
      service = "storage"
      resource_scope {
        resource_id   = var.folder_id
        resource_type = "resource-manager.folder"
      }
    }

    data_events_filter {
      service = "network"
      resource_scope {
        resource_id   = var.folder_id
        resource_type = "resource-manager.folder"
      }
    }

  }
}
