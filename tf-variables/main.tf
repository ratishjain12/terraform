terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.91.0"
    }
  }
}

provider "aws" {
    region = var.region
}

resource "aws_instance" "myserver" {
  ami = "ami-00bb6a80f01f03502"
  instance_type = var.ec2_config.instance_type

  root_block_device {
    volume_size = var.ec2_config.v_size
    volume_type = var.ec2_config.v_type
    delete_on_termination = true
  }

  tags = merge(var.additional_tags, {
    Name = "sample-server"
  })
}