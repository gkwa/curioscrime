source "incus" "homebrew" {
  image          = "001-homebrew-base"
  output_image   = "002-homebrew-configured"
  container_name = "homebrew-configured"
  reuse          = true
  skip_publish   = true
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

