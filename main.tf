terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# Configure the AWS Providers
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

## Security groups
module "sg" {
  source = ".//sg"
}

## AWS key
module "keys" {
  source   = ".//keys"
  key_path = ".//keys/pin.pem"
}

## AWS roles
resource "aws_iam_instance_profile" "resources-iam-profile" {
  name = "ec2-admin"
  role = aws_iam_role.resources-iam-role.name
}

resource "aws_iam_role" "resources-iam-role" {
  name        = "ec2-admin"
  description = "The role for infra EC2"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AdministratorAccess"
      }
    ]
  })
  
}

## EC2
#=================================================== Linux Server - PIN FINAL ====================================================
module "server_pin_final_web" {
  source               = ".//ec2-pin-final"
  sg-id                = module.sg.pin-final-server-sg
  instance_type        = "t2.micro"
  ami                  = "ami-0efcece6bed30fd98"
  volume_size          = "50"
  key-id               = module.keys.pin-id
  iam_instance_profile = aws_iam_instance_profile.resources-iam-profile.name
}
