output "kms_key_id" {
  description = "ID CMK для шифрования"
  value       = module.kms.id
}

output "terraform_sa_id" {
  description = "ID сервисного аккаунта Terraform"
  value       = module.terraform_sa.id
}

output "ansible_sa_id" {
  description = "ID сервисного аккаунта Ansible"
  value       = module.ansible_sa.id
}

output "sa_access_key" {
  value       = module.terraform_sa.sa_access_key
  sensitive   = true
  description = "Ключ доступа: сохраните в безопасном месте!"
}

output "sa_secret_key" {
  value       = module.terraform_sa.sa_secret_key
  sensitive   = true
  description = "Секретный ключ: сохраните в безопасном месте!"
}

output "tfstate_bucket_name" {
  description = "Имя бакета для хранения состояния Terraform"
  value       = module.tfstate_bucket.name
}
