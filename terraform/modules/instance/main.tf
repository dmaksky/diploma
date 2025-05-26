resource "yandex_compute_instance" "this" {
  name                      = var.name
  folder_id                 = var.folder_id
  zone                      = var.zone
  allow_stopping_for_update = true
  platform_id               = var.platform_id

  resources {
    cores  = var.cores
    memory = var.memory
  }

  boot_disk {
    initialize_params {
      image_id    = var.image_id
      type        = var.disk_type
      size        = var.disk_size
      kms_key_id  = var.key_id
    }
  }

  metadata = {
    enable-oslogin = true
  }

  dynamic "network_interface" {
    for_each = var.network_interfaces
    content {
      subnet_id          = network_interface.value.subnet_id
      ip_address         = network_interface.value.ipv4_address
      security_group_ids = network_interface.value.security_group_ids
      nat                = network_interface.value.nat
    }
  }

  scheduling_policy { preemptible = false }
  service_account_id = var.service_account_id
  labels             = var.labels
}
