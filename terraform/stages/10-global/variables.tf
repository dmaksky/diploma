variable "env" {
  description = "Целевая среда (dev | stage | prod)"
  type        = string
  validation {
    condition     = contains(["dev","stage","prod"], var.env)
    error_message = "env must be dev, stage or prod."
  }
}

variable "folder_id"       { type = string }
variable "cloud_id"        { type = string }

variable "zone" {
  validation {
    condition     = contains(["ru-central1-a", "ru-central1-b", "ru-central1-d"], var.zone)
    error_message = "zone must be ru-central1-a, ru-central1-b or ru-central1-d"
  }
}

variable "yc_token" {
  description = "IAM‑токен"
  type        = string
  sensitive   = true
}
