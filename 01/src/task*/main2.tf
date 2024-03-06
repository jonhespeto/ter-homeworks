terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
  required_version = ">=0.13" 
}

provider "docker" {
  host     = "ssh://server"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-i", "~/my_key_path", "-o", "UserKnownHostsFile=/dev/null"]
}

resource "random_password" "pass1" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "random_password" "pass2" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "docker_image" "mysql" {
  name         = "mysql:8"
}

resource "docker_container" "mysql" {
  image = docker_image.mysql.image_id
  name  = "mysql"
  env = [ "MYSQL_pass1WORD=${random_password.pass1.result}", 
          "MYSQL_DATABASE=wordpress", 
          "MYSQL_USER=wordpress", 
          "MYSQL_PASSWORD=${random_password.pass2.result}", 
          "MYSQL_ROOT_HOST=%"
          ]

  ports {
    internal = 3306
    external = 3306
    ip = "127.0.0.1"
  }
}