variable "name" {
  type        = string
  description = "Имя KMS key"
}

variable "description" {
  type        = string
  description = "Описание KMS key"
}

variable "rotation_period" {
  type        = string
  description = "Период ротации в формате ISO 8601 (например, 7776000s)"
  default     = "7776000s"
}

variable "labels" {
  type        = map(string)
  description = "Теги для KMS key"
  default     = {}
}
