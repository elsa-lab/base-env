#!/usr/bin/env bash

# Cause the script to exit on any errors
# Reference: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euo pipefail

# download VirtualGL
# curl -sSL https://sourceforge.net/projects/virtualgl/files/2.6.5/virtualgl_2.6.5_amd64.deb/download -o /tmp/virtualgl.deb

# create an appropriate xorg.conf file for headless operation
sudo nvidia-xconfig -a --allow-empty-initial-configuration --virtual=1920x1200

# install display manager
sudo apt install lightdm -y

# install VirtualGL
sudo dpkg -i /opt/base-env/Package/Archives/virtualgl_2.6.5_amd64.deb

# configure VirtualGL
sudo vglserver_config -config +s +f

# add users for accessing vglserver
sudo usermod -aG vglusers root

# restart display manager
sudo service lightdm restart

# disable suspend and hibernation modes 
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

echo -e "\e[5m\e[1mReboot required.\e[0m"
