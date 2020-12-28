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

  tags = merge(local.common_tags, local.worker_tags)

  # Creates three instances
  count = 3
}

resource "aws_instance" "controllers" {
  ami           = data.aws_ami.ubuntu_20_04_LTS.id
  instance_type = var.instance_type

  tags = merge(local.common_tags, local.controller_tags)

  # Creates three instances
  count = 3
}

output "workers_public_ip_addresses" {
  description = "The public ip address of every worker instance"
  value = [
    for worker in aws_instance.workers[*] : "Worker ${worker.id} has ip address ${worker.public_ip}"
  ]
}

output "controllers_public_ip_addresses" {
  description = "The public ip address of every controller instance"
  value = [
    for controller in aws_instance.controllers[*] : "Controller ${controller.id} has ip address ${controller.public_ip}"
  ]
}
