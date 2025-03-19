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

resource "random_id" "random-id" {
  byte_length = 8
}


resource "aws_s3_bucket" "webapp-bucket" {
  bucket = "webapp-bucket-${random_id.random-id.hex}"
  tags = {
    Name = "webapp-bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "webapp-bucket-public-access-block" {
  bucket = aws_s3_bucket.webapp-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "mywebapp-bucket-policy" {
  bucket = aws_s3_bucket.webapp-bucket.id
  policy = jsonencode(
    {
      Version = "2012-10-17",
      Statement = [
        {
          Sid       = "PublicReadGetObject",
          Effect    = "Allow",
          Principal = "*",
          Action    = "s3:GetObject",
          Resource  = "arn:aws:s3:::${aws_s3_bucket.webapp-bucket.id}/*"
        }
      ]
    }
  )
}

resource "aws_s3_bucket_website_configuration" "aws-s3-website" {
  bucket = aws_s3_bucket.webapp-bucket.id
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "index-html" {
  bucket       = aws_s3_bucket.webapp-bucket.id
  key          = "index.html"
  source       = "./index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "styles-css" {
  bucket       = aws_s3_bucket.webapp-bucket.id
  key          = "styles.css"
  source       = "./styles.css"
  content_type = "text/css"
}

output "website-url" {
  value = aws_s3_bucket_website_configuration.aws-s3-website.website_endpoint
}