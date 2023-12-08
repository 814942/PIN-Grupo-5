variable "sg-name" {
  description = "Security group id"
}

variable "tags" {
  type = map(string)
  default = {
    env     = "prod"
    project = "pin-final-grupo-5"
  }
}

variable "key-id" {
  default = "pin"
  description = "SSH key"
}

variable "instance_type" {
  description = "Type of EC2"
}

variable "ami" {
  default = "ami-0c55b159cbfafe1f0"
  description = "AMI id"
}

variable "iam_instance_profile" {
  description = "Role"
}

variable "volume_size" {
  description = "Disk size"
}