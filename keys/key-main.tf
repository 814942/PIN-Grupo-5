resource "aws_key_pair" "pin" {
  key_name   = "pin"
  public_key = file(var.key_path)
  tags = {
    Environment = var.tags["env"]
    project     = var.tags["project"]
  }
}
