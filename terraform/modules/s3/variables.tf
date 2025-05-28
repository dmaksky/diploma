variable "name" {
  type        = string
  description = "Имя бакета"
}

variable "folder_id" {
  description = "ID папки Яндекс Облака"
  type        = string
}

variable "default_storage_class" {
  type        = string
  description = "Класс хранения"
  default     = "STANDARD"
}

variable "kms_key_id" {
  type        = string
  description = "ID KMS ключа для шифрования"
}

variable "versioning_enabled" {
  type        = bool
  description = "Включить версионирование"
  default     = true
}

variable "lifecycle_enabled" {
  type        = bool
  description = "Включить удаление старых файлов"
  default     = false
}

variable "expire_rule" {
  type        = string
  description = "Название правила для ротирования файлов"
  default     = ""
}

variable "max_size" {
  type        = number
  description = "Максимальный размер бакета"
  default     = 1024 * 1024 * 1024
}

variable "labels" {
  type        = map(string)
  description = "Теги для бакета"
  default     = {}
}
