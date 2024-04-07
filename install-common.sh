#!/usr/bin/env bash

################################################################################
# Preamble
################################################################################

# Cause the script to exit on any errors
#
# Reference:
# https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -u

REPO_LINK="https://github.com/elsa-lab/base-env"
INSTALL_PATH="/opt/base-env"
MOTD_PATH="/etc/update-motd.d"
BIN_PATH="/usr/local/bin"

################################################################################
# System settings
################################################################################

# Extends the sudo timeout for another 15 mins
sudo -v

# Set DIR_MODE of adduser
#
# Reference:
# http://manpages.ubuntu.com/manpages/focal/man5/adduser.conf.5.html
sudo sed -i "s/DIR_MODE=0755/DIR_MODE=0700/" /etc/adduser.conf
chmod 700 ${HOME}

# Set timezone to Taipei
#
# Reference:
# http://manpages.ubuntu.com/manpages/focal/man1/timedatectl.1.html
sudo timedatectl set-timezone Asia/Taipei

# Generate keys for the elsa server to download installers
ssh-keygen -f ~/.ssh/elsa-server
ssh-copy-id -i ~/.ssh/elsa-server elsa.cs.nthu.edu.tw

################################################################################
# Installation
################################################################################

sudo git clone "${REPO_LINK}" "${INSTALL_PATH}"

# Update this package frequently
#
# Reference:
# https://stackoverflow.com/a/16068840
(sudo crontab -u root -l; echo "0 0 * * * cd ${INSTALL_PATH}; git pull") |
  sudo crontab -u root - 

#=====================================================================
# Part I: Package
#=====================================================================

cd ${INSTALL_PATH}/Package

#-----------------------------------------------------------
# Dependency and Service
#-----------------------------------------------------------

./Dependency/install-essential.sh
./Dependency/install-docker.sh
./Dependency/install-mujoco-roboti.sh
./Dependency/install-mujoco-deepmind.sh
./Dependency/install-python36-37.sh 

# Service
./Dependency/install-fail2ban.sh
./Dependency/install-hosts-monitor.sh
./Dependency/install-netdata.sh

#-----------------------------------------------------------
# NVIDIA related
#-----------------------------------------------------------

./NVIDIA/install-nv-driver.sh
./NVIDIA/install-cuda-cudnn.sh
./NVIDIA/install-nv-docker.sh

#-----------------------------------------------------------
# TigerVNC
#-----------------------------------------------------------

./TigerVNC/install-xfce4.sh
./TigerVNC/install-vncserver.sh

#-----------------------------------------------------------
# VirtualGL
#-----------------------------------------------------------

# ./Dependency/install-virtualgl.sh

#=====================================================================
# Part II: Script
#=====================================================================

cd ${INSTALL_PATH}/Script

#-----------------------------------------------------------
# User scripts
#-----------------------------------------------------------

for s in $(ls -A -I profile.d); do
  for ss in $(ls ${s}); do
    sudo ln -fns $(pwd)/${s}/${ss} ${BIN_PATH}/${ss}
  done
done

# VNC starting script should be in /usr/bin (same path of Xvnc)
sudo ln -fns $(pwd)/vnc/vncserver /usr/bin/vncserver
sudo rm /usr/local/bin/vncserver

#-----------------------------------------------------------
# profile.d
#-----------------------------------------------------------

for ss in $(ls -A profile.d); do
  sudo ln -fns $(pwd)/profile.d/${ss} /etc/profile.d/${ss}
done

#-----------------------------------------------------------
# motd
#-----------------------------------------------------------

# Enable necessary motds
sudo chmod -x ${MOTD_PATH}/*
sudo chmod +x ${MOTD_PATH}/00-header
sudo chmod +x ${MOTD_PATH}/97-overlayroot
sudo chmod +x ${MOTD_PATH}/98-fsck-at-reboot
sudo chmod +x ${MOTD_PATH}/98-reboot-required

# Install customized motds
sudo ln -fns $(pwd)/motd/fest-welcome ${MOTD_PATH}/02-fest-welcome
sudo ln -fns $(pwd)/motd/landscape-sysinfo ${MOTD_PATH}/50-landscape-sysinfo
sudo ln -fns $(pwd)/server_status/hdd-status ${MOTD_PATH}/51-hdd-status
sudo ln -fns $(pwd)/server_status/gpu-status ${MOTD_PATH}/52-gpu-status
sudo ln -fns $(pwd)/server_status/vnc-status ${MOTD_PATH}/53-vnc-status
sudo ln -fns $(pwd)/motd/ssh-banner-short ${MOTD_PATH}/56-ssh-banner-short

