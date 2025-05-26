variable "project_name" {
  description = "Project name, используется как префикс"
  type        = string
}

variable "cloud_id" {
  description = "ID облака Яндекс Облака"
  type        = string
}

variable "folder_id" {
  description = "ID папки Яндекс Облака"
  type        = string
}

variable "organization_id" {
  type        = string
  description = "ID организации" 
}

variable "yc_token" {
  description = "IAM‑токен"
  type        = string
  sensitive   = true
}

variable "zone" {
  description = "Зона доступности Яндекс Облака"
  type        = string
  default     = "ru-central1-b"
}
