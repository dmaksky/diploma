variable "zones" {
  description = "Список зон доступности"
  type        = list(string)
}

variable "image_id"               { type = string }
variable "access_key"             { type = string }
variable "secret_key"             { type = string }

variable "mgmt_platform_id" {
  type = string
  default = "standard-v1"
}

variable "mgmt_root_size"  { default = 30 }
variable "mgmt_cores"      { default = 2 }
variable "mgmt_memory"     { default = 2 }
variable "subnet_cidrs" {
  type = list
}
