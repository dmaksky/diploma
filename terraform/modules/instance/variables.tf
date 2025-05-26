variable "name"                  { type = string }
variable "folder_id"             { type = string }
variable "zone"                  { type = string }

variable "platform_id" {
  type = string
  default = "standard-v3"
}

variable "network_interfaces" {
  description = "Сетевые интерфейсы"
  type = list(object({
    subnet_id          = string
    ipv4_address       = optional(string)
    security_group_ids = optional(list(string))
    nat                = bool
  }))
}

variable "service_account_id"    { type = string }

variable "image_id" {
  description = "ID образа"
  type        = string
}

variable "disk_type" {
  description = "Тип диска"
  type        = string
  default     = "network-hdd"
}

variable "key_id" {
  description = "ID KMS"
  type        = string
}

variable "disk_size" {
  description = "Размер диска"
  type        = number
  default     = 30
}

variable "cores"                 { type = number }
variable "memory"                { type = number }

variable "labels" {
  type = map(string)
  default = {}
}
