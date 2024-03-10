#variable "vm_web_name" {
#  type        = string
#  default     = "netology-develop-platform-web"
#  description = "Name VM"
#}

# variable "vm_web_core" {
#   type        = number
#   default     = 2
#   description = "Cores"
# }

# variable "vm_web_memory" {
#   type        = number
#   default     = 1
#   description = "Memory"
# }

# variable "vm_web_core_fraction" {
#   type        = number
#   default     = 5
#   description = "Core fraction"
# }

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "Preemptible"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v1"
  description = "Platform standard"
}

variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM family"
}

variable "vm_web_nat" {
  type        = bool
  default     = true
  description = "Netvork nat"
}

###ssh vars

variable "vm_web_ssh_key" {
  type        = string
  default     = null
  description = "ssh-key for VM"
}

#variable "vm_db_name" {
#  type        = string
#  default     = "netology-develop-platform-db"
#  description = "Name vm_db"
#}

# variable "vm_db_core" {
#   type        = number
#   default     = 2
#   description = "Cores vm_db"
# }

# variable "vm_db_memory" {
#   type        = number
#   default     = 2
#   description = "Memory vm_db"
# }

# variable "vm_db_core_fraction" {
#   type        = number
#   default     = 20
#   description = "Core fraction vm_db"
# }

variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "Preemptible vm_db"
}

variable "vm_db_platform" {
  type        = string
  default     = "standard-v1"
  description = "Platform standard vm_db"
}

variable "vm_db_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM family vm_db"
}

variable "vm_db_nat" {
  type        = bool
  default     = true
  description = "Netvork nat vm_db"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "Zone vm_db"
}

variable "db_subnet" {
  type        = string
  default     = "develop-db"
  description = "db_subnet"
}

variable "vm_db_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vm_db_ssh_key" {
  type        = string
  default     = null
  description = "ssh-key for VM db"
}

variable "vms_resources" {
  type              = map
  default           = {
     web = {
     cores = 2
     memory = 1
     core_fraction = 5
     }
     db = {
     cores = 2
     memory = 2
     core_fraction = 20
     }
  }
 }

variable "metadata" {
  type = map
  default = {
    serial-port-enable = "1"
    ssh-keys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINTX80JJ3ek9fDBEIDjEaCHXUlFgOPkCNHlDe8rJwWLL"
  }
}