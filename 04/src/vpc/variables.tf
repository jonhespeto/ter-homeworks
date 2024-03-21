variable "dev_name" {
  type        = string
  default     = "develop"
  description = "Vpc module name"
}

variable "subnets" {
  type = list(object({
    zone = string,
    cidr = string
  }))
  default = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" }
  ]
}