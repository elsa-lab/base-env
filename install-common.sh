#!/bin/sh

WORKING_DIR=$(pwd)
ARCHI=$(uname -m)

# Check Architecture
if [ $(uname -m) != "x86_64" ]; then
  echo This Installation Flow only works on 64bit OS
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
./NVIDIA/install-cuda9-cudnn7.sh
./NVIDIA/install-nv-docker.sh
./NVIDIA/add-env-settings.sh

## Package: TigerVNC
./TigerVNC/install-xfce4.sh
./TigerVNC/install-vncserver.sh
./TigerVNC/add-env-settings.sh

# Part II: Service
cd ${WORKING_DIR}/Service

## Service: Basic System Information
./install-basic-sys-info.sh

## Service: Hosts Monitor
./install-hosts-monitor.sh

# Part III: MOTD
cd ${WORKING_DIR}/MOTD

./install-motd.sh
