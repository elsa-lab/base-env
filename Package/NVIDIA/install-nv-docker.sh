#!/bin/sh

# extends the sudo timeout for another 15 minutes
sudo -v

# remove old version and all existing GPU containers
sudo docker volume ls -q -f driver=nvidia-docker | \
  xargs -r -I{} -n1 sudo docker ps -q -a -f volume={} | \
  xargs -r sudo docker rm -f
sudo apt-get purge -y nvidia-docker

# add the package repositories
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu16.04/amd64/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list

# install nvidia-docker2
sudo apt-get update
sudo apt-get install -y nvidia-docker2

# reload the Docker daemon configuration
sudo pkill -SIGHUP dockerd
