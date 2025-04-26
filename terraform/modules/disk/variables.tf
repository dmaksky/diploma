variable "name"            { type = string }
variable "folder_id"       { type = string }
variable "zone"            { type = string }
variable "size"            { type = number }
variable "kms_key_id"      { type = string }

variable "type" {
  type = string
  default = "network-ssd"
}

variable "labels" {
  type = map(string)
  default = {}
}

variable "image_id" {
  type = string
  default = null
}
