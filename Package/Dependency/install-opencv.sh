#!/bin/bash

# Cause the script to exit on any errors
# Reference: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
# set -euo pipefail

# useful variables
CV2_RELEASE=2.4.11
CV3_RELEASE=3.2.0
CV_PATH="/opt/opencv"
CV_CON_PATH="/opt/opencv_contrib"

# clone the source code of opencv
## sudo git clone https://github.com/opencv/opencv.git "${CV_PATH}"
## sudo git clone https://github.com/opencv/opencv_contrib.git "${CV_CON_PATH}"

# extends the sudo timeout for another 15 minutes
sudo -v

# install dependencies of opencv
sudo apt update
sudo apt install -y liblapacke-dev 
sudo apt install -y libeigen3-dev

# build and install opencv2 without CUDA support
sudo -v
cd ${CV_PATH}
sudo git checkout ${CV2_RELEASE}
mkdir -p /tmp/opencv-${CV2_RELEASE}-build
cd /tmp/opencv-${CV2_RELEASE}-build
cmake -DCMAKE_BUILD_TYPE=Release \
      -DWITH_CUDA=OFF \
      -DCMAKE_INSTALL_PREFIX=/usr/local/opencv-${CV2_RELEASE} \
      "${CV_PATH}"
sudo make install -j`nproc`

# build and install opencv3 without CUDA support
sudo -v
cd ${CV_PATH}
sudo git checkout ${CV3_RELEASE}
cd ${CV_CON_PATH}
sudo git checkout ${CV3_RELEASE}
mkdir -p /tmp/opencv-${CV3_RELEASE}-build
cd /tmp/opencv-${CV3_RELEASE}-build
cmake -DCMAKE_BUILD_TYPE=Release \
      -DWITH_CUDA=OFF \
      -DCMAKE_INSTALL_PREFIX=/usr/local/opencv-${CV3_RELEASE} \
      -DOPENCV_EXTRA_MODULES_PATH=${CV_CON_PATH}/modules \
      ${CV_PATH}
sudo make install -j`nproc`

# clean up
# sudo rm -rf /tmp/opencv-${CV2_RELEASE}-build /tmp/opencv-${CV3_RELEASE}-build
