#!/usr/bin/env bash

set -e

# Initialize packer
packer init .

# Check and build base image if it doesn't exist
if ! incus image info 001-homebrew-base &>/dev/null; then
    echo "Building base image 001-homebrew-base..."
    packer build 001-ubuntu-homebrew-base.pkr.hcl
fi

# Check and build configured image if it doesn't exist
if ! incus image info 002-homebrew-configured &>/dev/null; then
    echo "Building configured image 002-homebrew-configured..."
    packer build 002-homebrew-configured.pkr.hcl
fi

# Clean up existing containers
incus info homebrew-configured &>/dev/null && incus rm --force homebrew-configured
incus info homebrew-setup &>/dev/null && incus rm --force homebrew-setup

terraform init

terraform plan -out=tfplan
terraform apply tfplan

incus exec homebrew-configured -- bash -l -c 'brew install hashicorp/tap/packer'
