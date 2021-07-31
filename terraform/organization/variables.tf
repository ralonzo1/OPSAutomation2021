data "terraform_remote_state" "organization" {
  backend = "local"

  config = {
    path = "terraform.tfstate"
  }
}
