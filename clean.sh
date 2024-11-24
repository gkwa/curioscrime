#!/usr/bin/env bash

set -e

# Clean up existing containers
incus info homebrew-configured &>/dev/null && incus rm --force homebrew-configured
incus info 001-homebrew-base &>/dev/null && incus rm --force 001-homebrew-base

# Clean up existing images
incus image info 002-homebrew-configured &>/dev/null && incus image rm 002-homebrew-configured
incus image info 001-homebrew-base &>/dev/null && incus image rm 001-homebrew-base
