output "tfstate_bucket" {
  value       = yandex_storage_bucket.tfstate.bucket
  description = "Имя созданного бакета для terraform.tfstate"
}

output "sa_access_key" {
  value       = yandex_iam_service_account_static_access_key.tf_sa_key.access_key
  sensitive   = true
}

output "sa_secret_key" {
  value       = yandex_iam_service_account_static_access_key.tf_sa_key.secret_key
  sensitive   = true
  description = "Секретный ключ: сохраните в безопасном месте!"
}

output "sa_id" {
  value       = yandex_iam_service_account.tf_sa.id
  description = "ID сервисного аккаунта Terraform"
}
