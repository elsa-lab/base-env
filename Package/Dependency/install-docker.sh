#!/usr/bin/env bash

# Cause the script to exit on any errors
# Reference:
# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euo pipefail

# extends the sudo timeout for another 15 minutes
sudo -v

UBUNTU_CODENAME=$(. /etc/os-release; echo $VERSION_CODENAME) # Ubuntu codename: noble (24.04)$
UBUNTU_NUMBER=$(. /etc/os-release; echo $VERSION_ID) # Ubuntu release number: 24.04 (noble)$

# uninstall old versions
for pkg in docker.io docker-doc docker-compose docker-compose-v2 containerd runc
do
  sudo apt remove -y $pkg
done

# install docker
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update

# Install the Docker packages
sudo apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

# start docker
sudo systemctl enable --now docker

# create the docker group
sudo getent group docker || sudo groupadd docker

# add current user to docker group
sudo usermod -aG docker ${USER}
