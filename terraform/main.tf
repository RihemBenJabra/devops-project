terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "docker" {}

resource "docker_image" "myapp" {
  name = "myapp-terraform"

  build {
    context    = "${path.module}/.."
    dockerfile = "${path.module}/../Dockerfile"
  }
}

resource "docker_container" "myapp" {
  name  = "app-terraform"
  image = docker_image.myapp.name

  ports {
    internal = 5000
    external = 5000
  }

}
