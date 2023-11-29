variable "sg-id" {
  description = "Security group id"
}

variable "tags" {
  type        = string
  default     = "pin-final-grupo-5"
  description = "Tags"
}

variable "key-id" {
  description = "SSH key"
}

variable "instance_type" {
  description = "Type of EC2"
}

variable "ami" {
  description = "AMI id"
}

variable "iam_instance_profile" {
  description = "Role"
}

variable "volume_size" {
  description = "Disk size"
}