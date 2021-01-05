# Creates a security group for workers
module "workers_security_group" {
  source              = "./modules/security-group"
  security_group_name = "workers_security_group"
  ingress_ports       = [22, 80]
}

# Creates a security group for controllers
module "controllers_security_group" {
  source              = "./modules/security-group"
  security_group_name = "workers_security_group"
  ingress_ports       = [22, 80]
}

resource "aws_instance" "workers" {
  ami             = data.aws_ami.ubuntu_20_04_LTS.id
  instance_type   = var.instance_type
  key_name        = "terraform-oregon"
  security_groups = [module.workers_security_group.security_group_name]
  # Spreads instances across AZ using "modulo" function
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available)]

  tags = merge(local.common_tags, local.worker_tags)

  # Instances count is set by `high_availability` variable
  count = (var.high_availability == true ? 3 : 1)
}

resource "aws_instance" "controllers" {
  ami           = data.aws_ami.ubuntu_20_04_LTS.id
  instance_type = var.instance_type
  # Spreads instances across AZ using "modulo" function
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available)]
  security_groups   = [module.controllers_security_group.security_group_name]

  tags = merge(local.common_tags, local.controller_tags)

  # Instances count is set by `high_availability` variable
  count = (var.high_availability == true ? 3 : 1)
}
