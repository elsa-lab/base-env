#!/bin/sh

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
if ! grep -q 'GRUB_CMDLINE_LINUX_DEFAULT="nomodeset"' /etc/default/grub; then
  echo Please run ./Package/NVIDIA/add-boot-option.sh then reboot
  exit 1
fi

# Part I: Package
cd ${WORKING_DIR}/Package

## Package: Dependency
./Dependency/install-essential.sh
./Dependency/install-opencv.sh
./Dependency/install-docker.sh

## Package: NVIDIA
./NVIDIA/install-nv-driver.sh
./NVIDIA/install-nv-docker.sh
./NVIDIA/install-cuda-cudnn.sh
./NVIDIA/add-cuda9-env.sh

## Package: TigerVNC
./TigerVNC/install-xfce4.sh
./TigerVNC/install-vncserver.sh
./TigerVNC/add-vnc-env.sh

# Part II: Service
cd ${WORKING_DIR}/Service

## Service: Basic System Information
./install-basic-sys-info.sh

## Service: Hosts Monitor
./install-hosts-monitor.sh

# Part III: MOTD
cd ${WORKING_DIR}/MOTD

./install-motd.sh
