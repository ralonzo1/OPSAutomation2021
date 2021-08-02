data "terraform_remote_state" "sg" {
  backend = "local"

  config = {
    path = "terraform.tfstate"
  }
}
