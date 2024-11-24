terraform {
  required_providers {
    incus = {
      source = "lxc/incus"
    }
  }
}

resource "incus_instance" "instance1" {
  image = "001-homebrew-base"
  name  = "001-homebrew-base"

  config = {
    "boot.autostart" = false
  }
}
