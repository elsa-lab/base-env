#!/bin/sh

# extends the sudo timeout for another 15 minutes
sudo -v

# install default packages
sudo apt-get update
sudo apt-get install -y --reinstall \
  smartmontools \
  build-essential \
  git curl wget \
  htop iotop \
  landscape-common \
  ppa-purge \
  screen tmux \
  fail2ban \
  sshfs \
  vim zip \
  ffmpeg \
  python-virtualenv \
  python-pip python-dev \
  python3-pip python3-dev
