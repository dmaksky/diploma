variable "name" {
  description = "Имя Lockbox-секрета"
  type        = string
}

variable "description" {
  description = "Описание секрета"
  type        = string
}

variable "folder_id" {
  description = "ID папки для Lockbox"
  type        = string
}

variable "kms_key_id" {
  type        = string
  description = "ID KMS ключа для шифрования"
}

variable "labels" {
  description = "Теги для Lockbox"
  type        = map(string)
  default     = {}
}

variable "deletion_protection" {
  description = "Включить защиту от удаления"
  type        = bool
  default     = true
}
