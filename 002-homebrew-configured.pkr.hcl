packer {
  required_plugins {
    incus = {
      version = ">= 1.0.5"
      source  = "github.com/bketelsen/incus"
    }
  }
}

source "incus" "homebrew" {
  image          = "001-homebrew-base"
  output_image   = "002-homebrew-configured"
  container_name = "002-homebrew-configured"
  reuse          = true
  skip_publish   = false
}

build {
  sources = ["incus.homebrew"]

  provisioner "shell" {
    inline = [
      "cloud-init status --wait",
    ]
  }

  provisioner "shell" {
    scripts = [
      "002-homebrew-configured.sh",
    ]
  }
}

