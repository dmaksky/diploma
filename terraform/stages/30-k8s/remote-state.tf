data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = local.bucket_name
    key    = "env:/${terraform.workspace}/10-network/terraform.tfstate"

    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }

    region                      = "ru-central1"
    secret_key                  = var.secret_key
    access_key                  = var.access_key

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

data "terraform_remote_state" "bootstrap" {
  backend = "local"

  config = {
    path = "../00-bootstrap/terraform.tfstate.d/${terraform.workspace}/terraform.tfstate"
  }
}
