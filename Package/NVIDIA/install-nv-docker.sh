#!/usr/bin/env bash

# Cause the script to exit on any errors
# Reference: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail
set -euo pipefail

# extends the sudo timeout for another 15 minutes
sudo -v

# add the package repositories
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
    sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
    sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt update

# install nvidia-doceker and restart docker
sudo apt install -y nvidia-docker2 nvidia-container-toolkit 
sudo systemctl restart docker

# Change the user who execute nvidia-container-toolkit
# Reference: https://askubuntu.com/a/1319123
sudo sed -i '/user/s/^#//g' /etc/nvidia-container-runtime/config.toml
