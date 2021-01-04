# Using a single workspace:
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "paolofilippelli"

    workspaces {
      name = "terraform-complete-example"
    }
  }
}