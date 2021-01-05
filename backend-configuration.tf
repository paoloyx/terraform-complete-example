# Using a single workspace:
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "paolofilippelli"

    workspaces {
      prefix = "terraform-complete-example-"
    }
  }
}