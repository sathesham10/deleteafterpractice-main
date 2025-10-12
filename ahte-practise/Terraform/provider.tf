terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "my-terraform-state-bucket-12345"  # Replace with your bucket name
    key    = "terraform/state.tfstate"
    region = "ap-south-1"
  }

  required_version = ">= 1.5.0"
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "demo_ec2" {
  ami           = "ami-0e306788ff2473ccb"   # Amazon Linux 2 (Mumbai)
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform-Demo-Instance"
  }
}

output "instance_public_ip" {
  value = aws_instance.demo_ec2.public_ip
}
