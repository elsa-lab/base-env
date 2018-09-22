#!/bin/sh

# extends the sudo timeout for another 15 minutes
sudo -v

# install default packages
sudo apt-get update
sudo apt-get install -y --reinstall \
  smartmontools dkms \
  htop iotop smem \
  build-essential \
  curl wget \
  landscape-common \
  ppa-purge \
  screen tmux \
  fail2ban sshfs \
  vim zip \
  ffmpeg \
  python-virtualenv \
  python-pip python-dev \
  python3-pip python3-dev
