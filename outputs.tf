output "workers_public_ip_addresses" {
  description = "The public ip address of every worker instance"
  value = [
    for worker in aws_instance.workers[*] : "Worker ${worker.id} is in AZ ${worker.availability_zone} and has ip address ${worker.public_ip}"
  ]
}

output "workers_security_group_name" {
  description = "The name of workers' security group"
  value       = module.workers_security_group.security_group_name
}

output "controllers_public_ip_addresses" {
  description = "The public ip address of every controller instance"
  value = [
    for controller in aws_instance.controllers[*] : "Controller ${controller.id} is in AZ ${controller.availability_zone} and has ip address ${controller.public_ip}"
  ]
}

output "controllers_security_group_name" {
  description = "The name of controllers' security group"
  value       = module.controllers_security_group.security_group_name
}
