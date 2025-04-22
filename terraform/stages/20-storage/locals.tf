locals {
  registry_name    = "${local.prefix}-registry"
  pg_bucket_name   = "${local.prefix}-pg-backups"
  loki_bucket_name = "${local.prefix}-loki-logs"

  pg_secrets_name   = "${local.prefix}-pg-secrets"
  loki_secrets_name = "${local.prefix}-loki-secrets"

  labels = {
    project     = var.project_name
    environment = terraform.workspace
    stage       = "20-storage"
  }
}
