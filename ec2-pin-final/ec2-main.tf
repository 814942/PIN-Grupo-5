resource "aws_instance" "app_server" {
  ami                  = var.ami
  instance_type        = var.instance_type
  key_name             = var.key-id
  iam_instance_profile = var.iam_instance_profile
  hibernation          = "false"
  security_groups      = [var.sg-id]
  root_block_device {
    volume_size           = var.volume_size
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }
  user_data       = file(".//user_data/ec2_user_data.sh")
  
}

#resource "aws_network_interface" "primary_interface" {
  #subnet_id       = ""
  #private_ips     = [""]
  #security_groups = [var.sg-id]
  #attachment {
    #instance     = aws_instance.app_server.id
    #device_index = 0
  #}
  #tags = (
    #var.tags
  #)
#}