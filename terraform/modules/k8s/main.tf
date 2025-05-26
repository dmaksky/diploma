resource "yandex_kubernetes_cluster" "k8s-cluster" {
  description = "Кластер k8s"
  name        = var.cluster_name
  network_id  = var.network_id

  master {
    regional {
      region = "ru-central1"
      location {
        zone      = var.zones[0]
        subnet_id = var.subnets_ids[0]
      }
      location {
        zone      = var.zones[1]
        subnet_id = var.subnets_ids[1]
      }
      location {
        zone      = var.zones[2]
        subnet_id = var.subnets_ids[2]
      }
    }

    maintenance_policy {
      auto_upgrade = true

      maintenance_window {
        day        = "monday"
        start_time = "15:00"
        duration   = "3h"
      }
    }
    security_group_ids = [var.security_group_ids["k8s_main"]]
    version            = var.k8s_version
    public_ip          = true
  }

  service_account_id      = var.k8s_sa_id # Cluster service account ID
  node_service_account_id = var.k8s_sa_id # Node group service account ID
  
  release_channel         = "STABLE"
  network_policy_provider = "CALICO"
  labels                  = merge(var.labels,{ role="k8s_masters" })
}

resource "yandex_kubernetes_node_group" "k8s-obs-node-group" {
  description = "Группа нод для сервисов observability"
  name        = var.obs_group_name
  cluster_id  = yandex_kubernetes_cluster.k8s-cluster.id
  version     = var.k8s_version

  scale_policy {
    fixed_scale {
      size = var.obs_group_size
    }
  }

  instance_template {
    platform_id = var.obs_group_platform

    network_interface {
      nat                = true
      subnet_ids         = var.subnets_ids
      security_group_ids = [var.security_group_ids["k8s_main"],var.security_group_ids["k8s_public_services"]]
    }

    resources {
      memory = var.obs_group_memory # RAM quantity in GB
      cores  = var.obs_group_cores  # Number of CPU cores
    }

    boot_disk {
      type = var.obs_group_disk_type
      size = var.obs_group_disk_size # Disk size in GB
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = "containerd"
    }

    metadata = {
      "enable-oslogin" = "true"
    }
  }

  allocation_policy {
    location {
      zone      = var.zones[0]
    }
    location {
      zone      = var.zones[1]
    }
    location {
      zone      = var.zones[2]
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

    maintenance_window {
      day        = "monday"
      start_time = "15:00"
      duration   = "3h"
    }
  }
  labels = merge(var.labels,{ role="k8s_obs_group" })
  node_labels = {
    "role" = "obs"
  }
}

resource "yandex_kubernetes_node_group" "k8s-pg-node-group" {
  description = "Группа нод для postgres"
  name        = var.pg_group_name
  cluster_id  = yandex_kubernetes_cluster.k8s-cluster.id
  version     = var.k8s_version

  #scale_policy {
  #  auto_scale {
  #    initial = var.pg_init_size
  #    min     = var.pg_min_size
  #    max     = var.pg_max_size
  #  } 
  #}

  scale_policy {
    fixed_scale {
      size = var.pg_group_size
    }
  }

  instance_template {
    platform_id = var.pg_group_platform

    network_interface {
      nat                = true
      subnet_ids         = var.subnets_ids
      security_group_ids = [var.security_group_ids["k8s_main"],var.security_group_ids["k8s_public_services"]]
    }

    resources {
      memory = var.pg_group_memory # RAM quantity in GB
      cores  = var.pg_group_cores  # Number of CPU cores
    }

    boot_disk {
      type = var.pg_group_disk_type
      size = var.pg_group_disk_size # Disk size in GB
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = "containerd"
    }

    metadata = {
      "enable-oslogin" = "true"
    }
  }

  allocation_policy {
    location {
      zone      = var.zones[0]
    }
    location {
      zone      = var.zones[1]
    }
    location {
      zone      = var.zones[2]
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

    maintenance_window {
      day        = "monday"
      start_time = "15:00"
      duration   = "3h"
    }
  }
  labels = merge(var.labels,{ role="k8s_pg_group" })
  node_labels = {
    "role" = "pg"
  }
}
