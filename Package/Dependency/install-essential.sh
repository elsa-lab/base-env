#!/bin/sh

# extends the sudo timeout for another 15 minutes
sudo -v

# install default packages
sudo apt-get update
sudo apt-get install -y \
  smartmontools dkms \
  htop iotop smem \
  build-essential cmake \
  curl wget \
  landscape-common \
  ppa-purge \
  screen tmux \
  sshfs \
  vim zip \
  ffmpeg \
  libosmesa6-dev \
  libgl1-mesa-dev \
  libopenmpi-dev \
  libopenblas-dev \
  zlib1g-dev \
  libboost-all-dev \
  libsdl2-dev \
  libsdl1.2-dev \
  libsdl-gfx1.2-dev \
  libsdl-image1.2-dev \
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

# install PatchELF (for mujoco-py)
sudo add-apt-repository -y ppa:jamesh/snap-support
sudo apt-get update
sudo apt-get install -y patchelf
