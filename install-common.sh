#!/bin/bash

WORKING_DIR=$(pwd)
MOTD_PATH="/etc/update-motd.d"
BIN_PATH="/usr/local/bin"
ARCHI=$(uname -m)

# Check Architecture
if [ ${ARCHI} != "x86_64" ]; then
  echo This Installation Flow only works on 64bit OS
  exit 1
fi

# Check NVIDIA GPU
if ! lspci | grep -q 'NVIDIA'; then
  echo This Installation Flow only works when NVIDIA GPU installed
  exit 1
fi

# Set DIR_MODE of adduser
sudo -v
sudo sed -i "s/DIR_MODE=0755/DIR_MODE=0700/" /etc/adduser.conf
chmod 700 ${HOME}

# Set timezone to Taipei
sudo timedatectl set-timezone Asia/Taipei

# Part I: Package
cd ${WORKING_DIR}/Package

## Package: Dependency
./Dependency/install-essential.sh
./Dependency/install-bazel.sh
./Dependency/install-docker.sh
./Dependency/install-mujoco.sh
./Dependency/install-python36-37.sh 
./Dependency/install-opencv.sh 
./Dependency/install-earlyoom.sh
./Dependency/install-fail2ban.sh
./Dependency/install-hosts-monitor.sh
./Dependency/install-netdata.sh

## Package: NVIDIA
./NVIDIA/install-nv-driver.sh
./NVIDIA/install-cuda-cudnn.sh

## Package: TigerVNC
./TigerVNC/install-xfce4.sh
./TigerVNC/install-vncserver.sh
./TigerVNC/install-essential.sh

# Part II: Script
cd ${WORKING_DIR}/Script

## Script: Installation except profile.d
for s in $(ls -A -I profile.d); do
  for ss in $(ls ${s}); do
    sudo ln -fns $(pwd)/${s}/${ss} ${BIN_PATH}/${ss}
  done
done

## Script: profile.d
for ss in $(ls -A profile.d); do
  sudo ln -fns $(pwd)/profile.d/${ss} /etc/profile.d/${ss}
done

## Script: motd
sudo chmod -x ${MOTD_PATH}/*
sudo chmod +x ${MOTD_PATH}/00-header
sudo chmod +x ${MOTD_PATH}/98-reboot-required

sudo ln -fns $(pwd)/motd/landscape-sysinfo ${MOTD_PATH}/50-landscape-sysinfo
sudo ln -fns $(pwd)/server_status/hdd-status ${MOTD_PATH}/51-hdd-status
sudo ln -fns $(pwd)/server_status/gpu-status ${MOTD_PATH}/52-gpu-status
sudo ln -fns $(pwd)/server_status/vnc-status ${MOTD_PATH}/53-vnc-status
sudo ln -fns $(pwd)/motd/ssh-banner-short ${MOTD_PATH}/56-ssh-banner-short
sudo ln -fns $(pwd)/motd/newline ${MOTD_PATH}/60-newline
