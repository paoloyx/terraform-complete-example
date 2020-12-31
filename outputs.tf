output "workers_public_ip_addresses" {
  description = "The public ip address of every worker instance"
  value = [
    for worker in aws_instance.workers[*] : "Worker ${worker.id} is in AZ ${worker.availability_zone} and has ip address ${worker.public_ip}"
  ]
}

output "controllers_public_ip_addresses" {
  description = "The public ip address of every controller instance"
  value = [
    for controller in aws_instance.controllers[*] : "Controller ${controller.id} is in AZ ${controller.availability_zone} and has ip address ${controller.public_ip}"
  ]
}