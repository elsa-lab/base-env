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

# Check Boot Option
if ! grep -q 'GRUB_CMDLINE_LINUX_DEFAULT.*nomodeset.*' /etc/default/grub; then
  echo Please run ./Package/NVIDIA/add-boot-option.sh then reboot
  exit 1
fi

# Set DIR_MODE of adduser
sudo -v
sudo sed -i "s/DIR_MODE=0755/DIR_MODE=0700/" /etc/adduser.conf
chmod 700 ${HOME}

# Part I: Package
cd ${WORKING_DIR}/Package

## Package: Dependency
./Dependency/install-essential.sh
./Dependency/install-bazel.sh
./Dependency/install-docker.sh
./Dependency/install-mujoco.sh
./Dependency/install-python36-37.sh 
./Dependency/install-opencv.sh 

## Package: NVIDIA
./NVIDIA/install-nv-driver.sh
./NVIDIA/install-cuda-cudnn.sh

## Package: TigerVNC
./TigerVNC/install-xfce4.sh
./TigerVNC/install-vncserver.sh
./TigerVNC/install-essential.sh
sudo cp ./TigerVNC/scripts/vncserver  /usr/bin/vncserver
sudo cp ./TigerVNC/scripts/vnc-pwdgen /usr/local/bin/vnc-pwdgen

# Part II: Service
cd ${WORKING_DIR}/Service

## Service: Basic System Information
./install-basic-sys-info.sh

## Service: Hosts Monitor
./install-hosts-monitor.sh

# Part III: Script
cd ${WORKING_DIR}/Script
sudo cp ./user_managment/* ${BIN_PATH}/
sudo cp ./server_status/* ${BIN_PATH}/

## Script: motd
sudo chmod -x ${MOTD_PATH}/10-help-text
sudo chmod -x ${MOTD_PATH}/90-updates-available
sudo chmod -x ${MOTD_PATH}/91-release-upgrade
sudo chmod -x ${MOTD_PATH}/97-overlayroot
sudo cp ./motd/* ${MOTD_PATH}/
sudo ln -s ${BIN_PATH}/hdd-status ${MOTD_PATH}/51-hdd-status
sudo ln -s ${BIN_PATH}/gpu-status ${MOTD_PATH}/52-gpu-status
sudo ln -s ${BIN_PATH}/vnc-status ${MOTD_PATH}/53-vnc-status
