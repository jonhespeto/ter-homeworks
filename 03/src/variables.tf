###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "web_count" {
  type        = number
  default     = 2
  description = "Count"
}

variable "vm_web_name" {
  type        = string
  default     = "web"
  description = "Name VM"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v1"
  description = "Platform standard"
}

variable "vms_resources" {
  type              = map
  default           = {
     web = {
     cores = 2
     memory = 1
     core_fraction = 5
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

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "Preemptible"
}

variable "vm_web_nat" {
  type        = bool
  default     = true
  description = "Network nat"
}

variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM family"
}

variable "vm_web_disk_size" {
  type        = number
  default     = 5
  description = "Disk size"
}

variable "allow_stopping" {
  type        = bool
  default     = true
  description = "allow_stopping_for_update"
}

variable "vm_db" {
  type = list(object({
    vm_name = string
    cores   = number
    memory  = number
    core_fraction = number
    public_ip   = bool
    platform    = string
    preemptible = bool
    allow_stopping_for_update = bool
    metadata = object({
      serial-port-enable = number
      })
    boot_disk     = object({
      initialize_params = object({
        size     = number
      })
    })
  }))
  default = [
    {
      vm_name       = "main"
      cores         = 4
      memory        = 2
      core_fraction = 5
      public_ip     = true
      platform      = "standard-v1"
      preemptible   = true
      allow_stopping_for_update = true
      metadata     = {
        serial-port-enable = 1
      }
      boot_disk     = {
        initialize_params = {
          size     = 5
        }
      }
    },
    {
      vm_name       = "replica"
      cores         = 2
      memory        = 1
      core_fraction = 20
      public_ip     = true
      platform      = "standard-v1"
      preemptible   = true
      allow_stopping_for_update = true
      metadata     = {
        serial-port-enable = 1
      }
      boot_disk     = {
        initialize_params = {
          size     = 5
        }
      }
    }
  ]

}

variable "disk_name" {
  type        = string
  default     = "disk"
  description = "Disks name"
}

variable "disk_count" {
  type        = number
  default     = 3
  description = "Count disk"
}

variable "disk_size" {
  type        = number
  default     = 1
  description = "Disks size"
}

variable "vm_storage_name" {
  type        = string
  default     = "storage"
  description = "vm_storage_name"
}

variable "vm_storage_core" {
  type        = number
  default     = 2
  description = "Cores"
}

variable "vm_storage_memory" {
  type        = number
  default     = 1
  description = "Memory size vm_storage"
}

variable "vm_storage_core_fraction" {
  type        = number
  default     = 5
  description = "storage_core_fraction"
}

variable "vm_storage_preemptible" {
  type        = bool
  default     = true
  description = "Storage vm scheduling policy preemptible"
}