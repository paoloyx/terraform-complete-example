terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  region     = "eu-west-3"
}

resource "aws_instance" "web" {
  ami           = "ami-00798d7180f25aac2"
  instance_type = "t2.micro"

  tags = {
    owner = "paolofilippelli"
    env   = "develop"
    app   = "udemy"
  }
}
