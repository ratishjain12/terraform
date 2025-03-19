terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.91.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.7.1"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "demo-bucket" {
  bucket = "demo-bucket-${random_id.random-id.hex}"
  tags = {
    Name = "demo-bucket"
  }
}

resource "random_id" "random-id" {
  byte_length = 8
}

resource "aws_s3_object" "bucket-data" {
  bucket = aws_s3_bucket.demo-bucket.id
  key    = "myfile.txt"
  source = "./myfile.txt"
}


