variable "name" {
  type        = string
  description = "Имя сервисного аккаунта"
}

variable "description" {
  type        = string
  description = "Описание SA"
}

variable "folder_id" {
  type        = string
  description = "ID папки"
}

variable "roles" {
  type        = list
  description = "Роли сервисного аккаунта"
}
