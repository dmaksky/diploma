resource "yandex_compute_instance_group" "this" {
  name               = var.name
  folder_id          = var.folder_id
  service_account_id = var.service_account_id

  instance_template {
    name        = "${var.name}-{instance.index}"
    platform_id = var.platform_id

    resources { 
      cores  = var.cores
      memory = var.memory
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id     = var.image_id
        size         = var.root_disk_size
        type         = var.disk_type
      }
    }

    secondary_disk {
      mode = "READ_WRITE"
      initialize_params {
        size       = var.data_disk_size
        type       = var.disk_type
      }
    }

    network_interface {
      network_id         = var.network_id
      subnet_ids         = var.subnet_ids
      security_group_ids = var.security_group_ids
      nat                = false
    }

    scheduling_policy { preemptible = false }

    metadata = {
      enable-oslogin = true
    }

    labels             = var.labels
  }

  allocation_policy {
    zones = [for z in var.zones : z]
  }

  deploy_policy {
    max_expansion   = 0
    max_unavailable = 1
  }

  scale_policy {
    auto_scale {
      min_zone_size = var.min_size / length(var.zones)
      max_size      = var.max_size
      initial_size  = var.min_size

      measurement_duration   = 60
      warmup_duration        = 60
      stabilization_duration = 120

      cpu_utilization_target = var.cpu_target

      dynamic "custom_rule" {
        for_each = var.memory_target != null ? [1] : []
        content {
          rule_type   = "WORKLOAD"
          metric_type = "GAUGE"
          metric_name = "vm.memory.usage_percent"
          target      = var.memory_target
        }
      }
    }
  }
}
