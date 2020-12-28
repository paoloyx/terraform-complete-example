data "aws_ami" "ubuntu_20_04_LTS" {

  filter {
    # Ubuntu 20.04 LTS Focal Fossa
    name = "name"
    values = [ "ubuntu/images/hvm-ssd/ubuntu-focal-20.04*" ]
  }

  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }


  owners      = ["099720109477"] #Canonical
  most_recent = true
}
