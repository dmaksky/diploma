variable "k8s_version" {
  description = "Версия Kubernetes"
  type        = string
}

variable "obs_size" {
  description = "Размер группы узлов для observability"
  type        = number
  default     = 3
}

variable "obs_platform" {
  description = "Платформа ВМ для observability"
  type        = string
  default     = "standard-v3"
}

variable "obs_memory" {
  description = "Объём памяти (ГБ) для observability"
  type        = number
  default     = 4
}

variable "obs_cores" {
  description = "Количество ядер для observability"
  type        = number
  default     = 2
}

variable "obs_disk_type" {
  description = "Тип диска для observability"
  type        = string
  default     = "network-hdd"
}

variable "obs_disk_size" {
  description = "Размер диска (ГБ) для observability"
  type        = number
  default     = 30
}

variable "pg_size" {
  description = "Размер группы узлов для PostgreSQL"
  type        = number
  default     = 3
}

#variable "pg_init_size" {
#  description = "Начальный размер node group для PostgreSQL"
#  type        = number
#  default     = 3
#}
#
#variable "pg_min_size" {
#  description = "Минимальный размер node group для PostgreSQL"
#  type        = number
#  default     = 3
#}
#
#variable "pg_max_size" {
#  description = "Максимальный размер node group для PostgreSQL"
#  type        = number
#  default     = 6
#}

variable "pg_platform" {
  description = "Платформа ВМ для PostgreSQL"
  type        = string
  default     = "standard-v3"
}

variable "pg_memory" {
  description = "Объём памяти (ГБ) для PostgreSQL"
  type        = number
  default     = 4
}

variable "pg_cores" {
  description = "Количество ядер для PostgreSQL"
  type        = number
  default     = 2
}

variable "pg_disk_type" {
  description = "Тип диска для PostgreSQL"
  type        = string
  default     = "network-hdd"
}

variable "pg_disk_size" {
  description = "Размер диска (ГБ) для PostgreSQL"
  type        = number
  default     = 30
}

variable "access_key"             { type = string }
variable "secret_key"             { type = string }

variable "zones" {
  description = "Список зон доступности"
  type        = list(string)
}
