output "pin-id" {
  description = "Key ID"
  value       = aws_key_pair.pin.id
}

output "pin-name" {
  description = "Key name"
  value       = aws_key_pair.pin.key_name
}
