variable "ami_name" {
  type    = string
  default = "elasticsearch-server-8.9-amazon-linux"
}

variable "profile" {
  type = string
}

variable "source_ami" {
  type = string
  default = "ami-02a89066c48741345"
}

variable "region" {
  type = string
  default = "us-east-2"
}

source "amazon-ebs" "amazon-linux" {
  ami_name      = var.ami_name
  profile       = var.profile
  instance_type = "t2.micro"
  region        = var.region
  source_ami    = var.source_ami
  ssh_username  = "ec2-user"

  tags = {
    Name = "elasticsearch-server-8.9-amazon-linux"
  }
}

build {
  name = "elasticsearch-packer"
  sources = [
    "source.amazon-ebs.amazon-linux"
  ]

  provisioner "shell" {
    script = "./elastickstack-install-amazon-linux.sh"
  }
}