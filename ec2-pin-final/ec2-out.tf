output "public_ip" {
  description = "Public IP"
  value       = aws_instance.app_server.public_ip
}

output "private_ip" {
  description = "Private IP"
  value       = aws_instance.app_server.private_ip
}

output "instance_id" {
  description = "Instance ID"
  value       = aws_instance.app_server.id
}