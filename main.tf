terraform {
  required_providers {
    incus = {
      source = "lxc/incus"
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
