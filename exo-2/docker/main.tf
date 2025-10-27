#############################################
# Exercice 2 - Option Docker 
#############################################

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {}

# Build custom image from Dockerfile
resource "docker_image" "custom_ubuntu" {
  name = "ubuntu-ssh:ansible"
  build {
    context = "${path.module}"
    dockerfile = "${path.module}/Dockerfile"
  }
}

# Start container with SSH
resource "docker_container" "my_vm" {
  name  = "openclassrooms-p6-exo2"
  image = docker_image.custom_ubuntu.image_id

  ports {
    internal = 22
    external = 2222
  }

  # Keep container running with SSHD
  command = ["/usr/sbin/sshd", "-D"]

  # Restart policy optional
  restart = "no"
}