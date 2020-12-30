# Security group for worker nodes
resource "aws_security_group" "workers_ssh_access" {
  name = "workers_ssh_access"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    # TODO: remove global access?
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "workers" {
  ami             = data.aws_ami.ubuntu_20_04_LTS.id
  instance_type   = var.instance_type
  key_name        = "terraform-oregon"
  security_groups = [aws_security_group.workers_ssh_access.name]

  tags = merge(local.common_tags, local.worker_tags)

  # Instances count is set by `high_availability` variable
  count = (var.high_availability == true ? 3 : 1)
}

resource "aws_instance" "controllers" {
  ami           = data.aws_ami.ubuntu_20_04_LTS.id
  instance_type = var.instance_type

  tags = merge(local.common_tags, local.controller_tags)

  # Instances count is set by `high_availability` variable
  count = (var.high_availability == true ? 3 : 1)
}