output "security_group_name" {
  description = "The name of security group name"
  value = aws_security_group.security_group.name
}