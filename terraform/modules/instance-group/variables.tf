variable "name"                { type = string }
variable "folder_id"           { type = string }
variable "zones"               { type = list(string) }

variable "platform_id" {
  type = string
  default = "standard-v3"
}

variable "network_id"          { type = string }
variable "subnet_ids"          { type = list(string) }
variable "security_group_ids"  { type = list(string) }
variable "service_account_id"  { type = string }
variable "image_id"            { type = string }
variable "root_disk_size"      { type = number }
variable "data_disk_size"      { type = number }

variable "disk_type" {
  type = string
  default = "network-ssd"
}

variable "cores"               { type = number }
variable "memory"              { type = number }
variable "min_size"            { type = number }
variable "max_size"            { type = number }

variable "cpu_target" {
  type = number
  default = 60
}
variable "memory_target" {
  type = number
  default = null
}
variable "labels" {
  type = map(string)
  default = {}
}
