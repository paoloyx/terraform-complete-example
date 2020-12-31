terraform {
  backend "s3" {
    bucket = "terraform-udemy-complete-example-backend"
    key    = "terraform-state"
    region = "us-west-2"
  }
}