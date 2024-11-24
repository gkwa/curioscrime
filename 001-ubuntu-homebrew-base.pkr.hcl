source "incus" "jammy" {
  image          = "images:ubuntu/jammy/cloud"
  output_image   = "001-homebrew-base"
  container_name = "001-homebrew-base"
  reuse          = true
  skip_publish   = false
}

build {
  sources = ["incus.jammy"]

  provisioner "shell" {
    inline = [
      "cloud-init status --wait",
    ]
  }

  provisioner "shell" {
    scripts = [
      "001-homebrew-base.sh",
    ]
  }
}

