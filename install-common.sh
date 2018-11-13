#!/bin/bash

WORKING_DIR=$(pwd)
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

# Set default umask
sudo -v
sudo sed -i "s/DIR_MODE=0755/DIR_MODE=0700/" /etc/adduser.conf
sudo sed -i "s/UMASK.*022/UMASK 077/" /etc/login.defs
chmod -R go-rwx ${HOME}

# Part I: Package
cd ${WORKING_DIR}/Package

## Package: Dependency
./Dependency/install-essential.sh
./Dependency/install-snoopy.sh
./Dependency/install-docker.sh
./Dependency/install-mujoco.sh

## Package: NVIDIA
./NVIDIA/install-nv-driver.sh
./NVIDIA/install-cuda-cudnn.sh

## Package: TigerVNC
./TigerVNC/install-xfce4.sh
./TigerVNC/install-vncserver.sh

# Part II: Service
cd ${WORKING_DIR}/Service

## Service: Basic System Information
./install-basic-sys-info.sh

## Service: Hosts Monitor
./install-hosts-monitor.sh

# Part III: MOTD
cd ${WORKING_DIR}/MOTD

./install-motd.sh
