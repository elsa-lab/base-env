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
  screen tmux \
  fail2ban sshfs \
  vim zip \
  ffmpeg \
  libosmesa6-dev \
  libgl1-mesa-dev \
  libopenmpi-dev \
  libopenblas-dev \
  python-virtualenv \
  python-opencv \
  python-tk \
  python-dev \
  python3-tk \
  python3-dev

# install Snoopy
sudo apt-get install -y debconf-utils
echo snoopy snoopy/install-ld-preload boolean true | sudo debconf-set-selections
sudo apt-get install -y snoopy
