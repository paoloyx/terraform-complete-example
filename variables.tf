variable "aws_region" {
  type        = string
  description = "The AWS region where resources will be created"
  default     = "eu-west-3"
}

variable "instance_type" {
  type        = string
  description = "The instance type that will be used to provision EC2 instances"
  default     = "t2.micro"
}
}
