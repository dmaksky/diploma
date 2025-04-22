variable "network_name" {
  description = "Имя облачной сети"
  type        = string
}

variable "folder_id" {
  description = "ID папки Яндекс Облака"
  type        = string
}

variable "gateway_id" {
  description = "ID NAT шлюза"
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

variable "private_subnet_cidrs" {
  description = "CIDR для private-подсетей"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR для public-подсетей"
  type        = list(string)
}
