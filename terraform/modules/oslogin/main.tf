resource "yandex_organizationmanager_os_login_settings" "this" {
  organization_id = var.organization_id
  ssh_certificate_settings {
    enabled = true
  }
  user_ssh_key_settings {
    enabled               = true
    allow_manage_own_keys = true
  }
}
