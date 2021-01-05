variable "security_group_name" {
  type        = string
  description = "The security group name"
}

variable "ingress_ports" {
  type        = list(number)
  description = "These ports will be opened in ingress on every EC2 instance"
}