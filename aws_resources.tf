# Security group for worker nodes
resource "aws_security_group" "workers_security_group" {
  name = "workers_security_group"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    # TODO: remove global access?
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    # TODO: remove global access?
    cidr_blocks = ["0.0.0.0/0"]
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

  tags = merge(local.common_tags, local.worker_tags)

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/terraform-oregon.pem")
    host        = self.public_ip
  }

  # Echoing just to gain time and ensure istance is ready before actually
  # executing "real" local-exec provider
  provisioner "remote-exec" {
    inline = ["echo 'Hello World! My work is to allow local-exec do its duty - a very ugly workaround!'"]

  }

  # Uses ansible to install nginx
  provisioner "local-exec" {
    command = "ansible-playbook -i '${self.public_ip},' --private-key '${path.module}/terraform-oregon.pem' ansible-playbooks/install-nginx.yml"

  }

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