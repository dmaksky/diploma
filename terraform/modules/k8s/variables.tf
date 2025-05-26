variable "zones" {
  description = "Список зон доступности"
  type        = list(string)
}

variable "k8s_version" {
  description = "Версия k8s"
  type        = string
}

variable "cluster_name" {
  description = "Имя кластера"
  type        = string
}

variable "obs_group_name" {
  description = "Имя группы observability нод"
  type        = string
}

variable "pg_group_name" {
  description = "Имя групп PostgreSQL нод"
  type        = string
}

variable "k8s_sa_id" {
  description = "ID сервисного аккаунта для кластера и нод"
  type        = string
}

variable "obs_group_size" {
  description = "Размер фиксированной группы нод observability"
  type        = number
}

variable "obs_group_platform" {
  description = "Платформа ВМ для observability нод"
  type        = string
}

variable "obs_group_memory" {
  description = "Объем памяти (ГБ) для observability нод"
  type        = number
}

variable "obs_group_cores" {
  description = "Количество ядер для observability нод"
  type        = number
}

variable "obs_group_disk_type" {
  description = "Тип диска для observability нод"
  type        = string
}

variable "obs_group_disk_size" {
  description = "Размер диска (ГБ) для observability нод"
  type        = number
}

#variable "pg_init_size" {
#  description = "Начальное количество нод в группе PostgreSQL"
#  type        = number
#}
#
#variable "pg_min_size" {
#  description = "Минимальное количество нод в группе PostgreSQL"
#  type        = number
#}
#
#variable "pg_max_size" {
#  description = "Максимальное количество нод в группе PostgreSQL"
#  type        = number
#}
#
variable "pg_group_size" {
  description = "Размер фиксированной группы нод PostgreSQL"
  type        = number
}

variable "pg_group_platform" {
  description = "Платформа ВМ для PostgreSQL нод"
  type        = string
}

variable "pg_group_memory" {
  description = "Объем памяти (ГБ) для PostgreSQL нод"
  type        = number
}

variable "pg_group_cores" {
  description = "Количество ядер для PostgreSQL нод"
  type        = number
}

variable "pg_group_disk_type" {
  description = "Тип диска для PostgreSQL нод"
  type        = string
}

variable "pg_group_disk_size" {
  description = "Размер диска (ГБ) для PostgreSQL нод"
  type        = number
}

variable "labels" {
  type = map(string)
  default = {}
}

variable "network_id"          { type = string }
variable "subnets_ids"         { type = list(string) }
variable "security_group_ids"  { type = map }
