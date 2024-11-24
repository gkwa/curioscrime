terraform {
  required_providers {
    incus = {
      source  = "lxc/incus"
      version = ">= 0.1.0"
    }
  }
}

resource "incus_instance" "instance1" {
  image = "002-homebrew-configured"
  name  = "002-homebrew-configured"

  config = {
    "boot.autostart" = false
  }
}
