#!/bin/bash

# extends the sudo timeout for another 15 minutes
sudo -v

# uninstall old versions, it’s OK if apt-get reports that none of these packages are installed
sudo apt-get purge -y docker docker-engine docker.io

# add the package repositories
sudo apt-get update
sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo apt-key add -
sudo add-apt-repository -y \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# install docker CE
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# install docker compose
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) \
  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
