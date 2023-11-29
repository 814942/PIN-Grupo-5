variable "key_path" {
  description = "Path of key public file"
}

variable "tags" {
  type = map(string)
  default = {
    env     = "prod"
    project = "pin-final-grupo-5"
  }
}