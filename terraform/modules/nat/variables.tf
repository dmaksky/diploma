variable "name" {
  description = "Имя NAT-шлюза"
  type        = string
}

variable "folder_id" {
  description = "ID папки для NAT"
  type        = string
}

variable "labels" {
  description = "Теги для NAT-шлюза"
  type        = map(string)
}
