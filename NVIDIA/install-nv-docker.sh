#!/bin.sh

sudo -v
sudo docker volume ls -q -f driver=nvidia-docker | \
  xargs -r -I{} -n1 sudo docker ps -q -a -f volume={} | \
  xargs -r sudo docker rm -f
sudo apt-get purge -y nvidia-docker
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu16.04/amd64/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo pkill -SIGHUP dockerd
