resource "aws_instance" "app_server" {
  ami                  = var.ami
  instance_type        = var.instance_type
  key_name             = var.key-id
  iam_instance_profile = var.iam_instance_profile
  hibernation          = "false"
  security_groups      = [var.sg-name]
  root_block_device {
    volume_size           = var.volume_size
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }
  user_data       = file(".//user_data/ec2_user_data.sh")
  tags = {
    Environment = var.tags["env"]
    project     = var.tags["project"]
  }
}