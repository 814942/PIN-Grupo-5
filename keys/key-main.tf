resource "aws_key_pair" "pin" {
  key_name   = "pin"
  public_key = file(var.key_path)
}
