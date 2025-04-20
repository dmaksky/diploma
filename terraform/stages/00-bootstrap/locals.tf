locals {
  project = "pg-gitops"
  tags    = { project = local.project, stage = "bootstrap" }
}
