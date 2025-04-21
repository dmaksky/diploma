resource "yandex_container_registry" "cr" {
  name        = "cr-${var.env}"
  folder_id   = var.folder_id
  labels = {
    env     = var.env
    project = local.project
    stage   = local.stage
  }
}

resource "yandex_logging_group" "logs" {
  name                  = "logs-${var.env}"
  retention_period      = "720h"
  folder_id             = var.folder_id
  description           = "Группа логгирования"
  labels = {
    env     = var.env
    project = local.project
    stage   = local.stage
  }
}

resource "yandex_audit_trails_trail" "basic_trail" {
  name        = "basic-trail-${var.env}"
  folder_id   = var.folder_id
  description = "Базовый трейл"

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

  labels = {
    env     = var.env
    project = local.project
    stage   = local.stage
  }
}
