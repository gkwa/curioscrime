terraform {
  required_providers {
    incus = {
      source = "lxc/incus"
    }
  }
}

resource "incus_instance" "instance1" {
  image = "homebrew-configured"
  name  = "homebrew-configured"

  config = {
    "boot.autostart" = false
  }
}
