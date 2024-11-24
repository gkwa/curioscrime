#!/usr/bin/env bash

set -e

packer init .

if ! incus image info 001-homebrew-base &>/dev/null; then
    echo "Building base image 001-homebrew-base..."
    packer build 001-ubuntu-homebrew-base.pkr.hcl
fi

if ! incus image info 002-homebrew-configured &>/dev/null; then
    echo "Building configured image 002-homebrew-configured..."
    packer build 002-homebrew-configured.pkr.hcl
fi

# Clean up existing containers
incus info 002-homebrew-configured &>/dev/null && incus rm --force 002-homebrew-configured
incus info 001-homebrew-setup &>/dev/null && incus rm --force 001-homebrew-setup

terraform init
terraform plan -out=tfplan
terraform apply tfplan

incus exec 002-homebrew-configured -- bash -l -c 'brew install hashicorp/tap/packer && packer version'
incus exec 002-homebrew-configured -- bash -l -c 'packer version'
