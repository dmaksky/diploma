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

variable "boot_disk_id" {
  type    = string
}

variable "cores"                 { type = number }
variable "memory"                { type = number }

variable "additional_disk_ids" {
  type = list(string)
  default = []
}

variable "labels" {
  type = map(string)
  default = {}
}
