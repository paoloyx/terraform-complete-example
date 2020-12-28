terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "web" {
  ami           = "ami-00798d7180f25aac2"
  instance_type = var.instance_type

  tags = {
    owner = "paolofilippelli"
    env   = "develop"
    app   = "udemy"
  }
}
