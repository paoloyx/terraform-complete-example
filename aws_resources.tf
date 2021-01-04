# Security group for worker nodes
resource "aws_security_group" "workers_security_group" {
  name = "workers_security_group"

  # Configures ingress ports using dynamic blocks
  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      # TODO: remove global access?
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "workers" {
  ami             = data.aws_ami.ubuntu_20_04_LTS.id
  instance_type   = var.instance_type
  key_name        = "terraform-oregon"
  security_groups = [aws_security_group.workers_security_group.name]
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

  tags = merge(local.common_tags, local.controller_tags)

  # Instances count is set by `high_availability` variable
  count = (var.high_availability == true ? 3 : 1)
}
