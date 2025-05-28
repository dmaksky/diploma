variable "network_name" {
  description = "Имя облачной сети"
  type        = string
}

variable "folder_id" {
  description = "ID папки Яндекс Облака"
  type        = string
}

variable "nat_name" {
  description = "Имя NAT-шлюза"
  type        = string
}

variable "zones" {
  description = "Список зон доступности"
  type        = list(string)
}

variable "labels" {
  description = "Теги для ресурсов"
  type        = map(string)
}

variable "rt_name" {
  description = "Имя таблицы маршрутизации"
  type        = string
}

variable "subnet_cidrs" {
  description = "CIDR для подсетей"
  type        = list(string)
}
