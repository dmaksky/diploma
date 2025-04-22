data "terraform_remote_state" "bootstrap" {
  backend = "local"

  config = {
    path = "../00-bootstrap/terraform.tfstate"
  }
}
