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

variable "network_name"  { type = string }

variable "subnets" {
  description = "Карта подсетей: ключ — логическое имя"
  type = map(object({
    name  = string
    zone  = string
    cidr  = string
  }))
  default = {
    private-a = { name = "private-a", zone = "ru-central1-a", cidr = "10.10.0.0/24" }
    private-b = { name = "private-b", zone = "ru-central1-b", cidr = "10.10.1.0/24" }
    private-d = { name = "private-d", zone = "ru-central1-d", cidr = "10.10.2.0/24" }
  }
}

variable "admin_cidrs" {
  description = "Список CIDR‑сетей, с которых разрешён SSH/Ansible."
  type        = list(string)
}
