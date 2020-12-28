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

resource "aws_instance" "workers" {
  ami           = data.aws_ami.ubuntu_20_04_LTS.id
  instance_type = var.instance_type

  tags = {
    owner = "paolofilippelli"
    env   = "develop"
    app   = "udemy"
  }

  # Creates three instances
  count = 3
}
