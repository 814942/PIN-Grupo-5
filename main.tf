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
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "ec2-describe-instances" {
  name        = "ec2-describe-instances-policy"
  description = "Policy to describe EC2 instances"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "ec2:DescribeInstanceTypeOfferings",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach-describe-instances-policy" {
  policy_arn = aws_iam_policy.ec2-describe-instances.arn
  role       = aws_iam_role.resources-iam-role.name
}

resource "aws_iam_policy" "ec2-admin-policy" {
  name        = "ec2-admin-policy"
  description = "Policy for EC2 admin role"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:*",
          "iam:*",
          "eks:*",
          "cloudformation:*"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach-ec2-admin-policy" {
  policy_arn = aws_iam_policy.ec2-admin-policy.arn
  role       = aws_iam_role.resources-iam-role.name
}

## EC2
#=================================================== Linux Server - PIN FINAL ====================================================
module "server_pin_final_web" {
  source               = ".//ec2-pin-final"
  sg-name              = module.sg.pin-final-server-sg
  instance_type        = "t2.small"
  ami                  = "ami-07b36ea9852e986ad"
  volume_size          = 50
  key-id               = module.keys.pin-id
  iam_instance_profile = aws_iam_instance_profile.resources-iam-profile.name
}
