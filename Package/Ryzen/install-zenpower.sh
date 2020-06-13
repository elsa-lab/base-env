#!/usr/bin/env bash

# Cause the script to exit on any errors
# Reference: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euo pipefail

# extends the sudo timeout for another 15 minutes
sudo -v 

# install this module via dkms
sudo apt install -y \
  dkms \
  git \
  build-essential \
  linux-headers-$(uname -r)
git clone https://github.com/ocerman/zenpower.git /tmp/zenpower
cd /tmp/zenpower
sudo make dkms-install

# module activation
sudo modprobe -r k10temp
sudo bash -c 'sudo echo -e "\n# replaced with zenpower\nblacklist k10temp" >> /etc/modprobe.d/blacklist.conf'
sudo modprobe zenpower

