variable "zones" {
  description = "Список зон доступности"
  type        = list(string)
}

variable "image_family"           { type = string }
variable "image_id"               { type = string }
variable "access_key"             { type = string }
variable "secret_key"             { type = string }

variable "master_platform_id" {
  type = string
  default = "standard-v3"
}

variable "worker_platform_id" {
  type = string
  default = "standard-v3"
}

variable "bastion_platform_id" {
  type = string
  default = "standard-v1"
}

variable "master_root_size"   { default = 10 }
variable "master_data_size"   { default = 10 }
variable "worker_root_size"   { default = 10 }
variable "worker_data_size"   { default = 10 }
variable "bastion_root_size"  { default = 10 }

variable "master_cores"   { default = 2 }
variable "master_memory"  { default = 2 }
variable "worker_cores"   { default = 2 }
variable "worker_memory"  { default = 2 }
variable "bastion_cores"  { default = 2 }
variable "bastion_memory" { default = 2 }

variable "worker_min" { default = 3 }
variable "worker_max" { default = 9 }

variable "worker_cpu_utilization" { default = 60 }
variable "worker_memory_target"   { default = null }
