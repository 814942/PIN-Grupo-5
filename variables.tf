variable "tags" {
  type = map(string)
  default = {
    env     = "prod"
    project = "pin-final-grupo-5"
  }
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Aws region"
}

variable "access_key" {
  default = "access_key"
}

variable "secret_key" {
  default = "secret_key"
}