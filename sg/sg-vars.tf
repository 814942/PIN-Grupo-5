variable "tags" {
  type = map(string)
  default = {
    env     = "prod"
    project = "pin-final-grupo-5"
  }
}

variable "description" {
  default = "Reglas del servidor server_pin_final_web"
  description = "Reglas del servidor server_pin_final_web"
}

variable "name" {
  default = "pin-final-sg"
  description = "pin-final-sg"
}