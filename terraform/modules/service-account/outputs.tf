output "id" {
  value       = yandex_iam_service_account.this.id
  description = "ID сервисного аккаунта"
}

output "name" {
  value       = yandex_iam_service_account.this.name
  description = "Имя сервисного аккаунта"
}

output "sa_access_key" {
  value       = yandex_iam_service_account_static_access_key.this.access_key
  sensitive   = true
  description = "Ключ доступа: сохраните в безопасном месте!"
}

output "sa_secret_key" {
  value       = yandex_iam_service_account_static_access_key.this.secret_key
  sensitive   = true
  description = "Секретный ключ: сохраните в безопасном месте!"
}
