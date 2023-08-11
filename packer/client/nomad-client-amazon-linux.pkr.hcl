variable "amazon_linux_ami_name" {
  type    = string
  default = "nomad-client-amazon-linux"
}

variable "ubuntu_linux_ami_name" {
  type = string
  default = "nomad-client-ubuntu-linux"
}

variable "profile" {
  type = string
}

variable "amazon_source_ami" {
  type = string
}

variable "ubuntu_source_ami" {
  type = string
  default = "ami-06c4532923d4ba1ec"
}

variable "region" {
  type = string
  default = "us-east-2"
}


source "amazon-ebs" "amazon-linux" {
  ami_name      = var.amazon_linux_ami_name
  profile = var.profile
  instance_type = "t2.micro"
  region        = var.region
  source_ami    = var.amazon_source_ami
  ssh_username  = "ec2-user"

  tags = {
    Name = "Nomad-Client-1.6.0-amazon-linux"
  }
}

source "amazon-ebs" "ubuntu-linux" {
  ami_name      = var.ubuntu_linux_ami_name
  profile = var.profile
  instance_type = "t2.micro"
  region        = "us-east-2"
  source_ami    = "ami-06c4532923d4ba1ec"
  ssh_username  = "ubuntu"

  tags = {
    Name = "Nomad-Client-1.6.0-ubuntu-linux"
  }
}

build {
  name = "nomad-packer-amazon"
  sources = [
    "source.amazon-ebs.amazon-linux"
  ]

  provisioner "shell" {
    script = "./nomad-client-install-amazon-linux.sh"
  }
}

build {
  name = "nomad-packer-ubuntu"
  sources = [
    "source.amazon-ebs.ubuntu-linux"
  ]

  provisioner "shell" {
    script = "./nomad-client-install-ubuntu-linux.sh"
  }
}
