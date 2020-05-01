#!/usr/bin/env bash

# Cause the script to exit on any errors
# Reference: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail
set -euo pipefail

# extends the sudo timeout for another 15 minutes
sudo -v

# disable default video driver
sudo sed -i \
  's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="nomodeset"/g' \
  /etc/default/grub
sudo update-grub

echo -e "\e[5m\e[1mPlease reboot before NVIDIA driver installation\e[0m"
echo -e "P.S. Please add \033[0;32mpcie_aspm=off\033[0m manually if using \033[0;31mThreadripper\033[0m"
