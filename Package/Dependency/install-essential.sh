#!/bin/sh

# extends the sudo timeout for another 15 minutes
sudo -v

# install default packages
sudo apt-get update
sudo apt-get install -y \
  smartmontools dkms \
  htop iotop smem \
  build-essential \
  curl wget \
  landscape-common \
  ppa-purge \
  trash-cli \
  screen tmux \
  fail2ban sshfs \
  vim zip \
  ffmpeg \
  python-virtualenv \
  python-dev \
  python3-dev
