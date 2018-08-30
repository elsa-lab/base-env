#!/bin/sh

./Dependency/install-essential.sh
./Dependency/install-opencv.sh
./NVIDIA/install-nv-driver.sh
./NVIDIA/install-cuda9-cudnn7.sh
./NVIDIA/add-env-settings.sh
./TigerVNC/install-xfce4.sh
./TigerVNC/install-vncserver.sh
./TigerVNC/add-env-settings.sh
