#!/usr/bin/env bash

# Cause the script to exit on any errors
# Reference:
# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euo pipefail

# extends the sudo timeout for another 15 minutes
sudo -v

# update apt repo
sudo apt update

# install docker
sudo apt install -y docker.io

# start docker
sudo systemctl enable --now docker

# add current user to docker group
sudo usermod -aG docker ${USER}

