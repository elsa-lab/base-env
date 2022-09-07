#!/usr/bin/env bash

# Cause the script to exit on any errors
# Reference: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euo pipefail

# extends the sudo timeout for another 15 minutes
sudo -v

# update apt repo
sudo apt update

# monitoring tools
sudo apt install -y smartmontools \
                    htop \
                    iotop \
                    iftop \
                    smem \
                    earlyoom

# commonly used apps
sudo apt install -y dkms \
                    build-essential \
                    cmake \
                    curl \
                    wget \
                    screen \
                    tmux \
                    sshfs \
                    vim \
                    zip \
                    ppa-purge \
                    apt-file \
                    moutil

# commonly used libraries
sudo apt install -y ffmpeg \
                    libopencv-dev \
                    libosmesa6-dev \
                    libgl1-mesa-dev \
                    libopenmpi-dev \
                    libopenblas-dev \
                    zlib1g-dev \
                    libboost-all-dev \
                    libsdl2-dev \
                    libsdl1.2-dev \
                    libsdl-gfx1.2-dev \
                    libsdl-image1.2-dev

# python3 related libraries
sudo apt install -y python3-virtualenv \
                    python3-dev \
                    python3-tk

