terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.4.0"
    }
  }
}

terraform {
  backend "remote" {
    organization = "Terraform-IaC"

    workspaces {
      name = "Terraform-EC2-S3"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


locals {
  project_name = "Cloud"
}

resource "aws_instance" "webserver" {
  ami           = "ami-022e1a32d3f742bd8"
  instance_type = var.instance_type

  tags = {
    Name = "${local.project_name}-Webserver"
  }
}

resource "aws_s3_bucket" "s3bucket" {
  bucket = "s3bucket09122023"
}

output "public_ip" {
  value = aws_instance.webserver.public_ip
}
