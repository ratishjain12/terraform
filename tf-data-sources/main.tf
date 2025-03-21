terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.91.0"
    }
  }
}

provider "aws" {
  region = var.region
}


data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

data "aws_security_group" "ec2_sg" {
    tags = {
      ec2 = "sg"
    }
}

data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_availability_zones" "azs" {
  state = "available"
}

resource "aws_instance" "myserver" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.nano"
  tags = {
    Name = "my-server"
  }
}


output "aws_ami_id" {
  value = data.aws_ami.ubuntu.id
}

output "aws_security_group_id" {
  value = data.aws_security_group.ec2_sg.id
}

output "aws_vpc_id" {
  value = data.aws_vpc.default_vpc.id
}

output "aws_azs" {
  value = data.aws_availability_zones.azs.names
}


