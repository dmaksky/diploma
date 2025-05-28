resource "yandex_iam_service_account" "this" {
  name        = var.name
  description = var.description
}

resource "yandex_resourcemanager_folder_iam_member" "this" {
  for_each  = toset(var.roles)
  folder_id = var.folder_id
  role      = each.key
  member    = "serviceAccount:${yandex_iam_service_account.this.id}"
}

resource "yandex_iam_service_account_static_access_key" "this" {
  service_account_id = yandex_iam_service_account.this.id
  description        = "Статический ключ сервисного аккаунта для доступа к бакету"
}
