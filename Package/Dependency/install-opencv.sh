#!/bin/sh

# useful variables
CV2_RELEASE=2.4.11
CV3_RELEASE=3.2.0

# clone the source code of opencv
git clone https://github.com/opencv/opencv.git /tmp/opencv
git clone https://github.com/opencv/opencv_contrib.git /tmp/opencv_contrib

# extends the sudo timeout for another 15 minutes
sudo -v

# install dependencies of opencv
sudo apt update
sudo apt install -y liblapacke-dev 
sudo apt install -y libeigen3-dev

# build and install opencv2 without CUDA support
sudo -v
cd /tmp/opencv
git checkout ${CV2_RELEASE}
mkdir -p /tmp/opencv-${CV2_RELEASE}-build
cd /tmp/opencv-${CV2_RELEASE}-build
cmake -DCMAKE_BUILD_TYPE=Release \
      -DWITH_CUDA=OFF \
      -DCMAKE_INSTALL_PREFIX=/usr/local/opencv-${CV2_RELEASE} \
      /tmp/opencv
sudo make install -j

# build and install opencv3 without CUDA support
sudo -v
cd /tmp/opencv
git checkout ${CV3_RELEASE}
cd /tmp/opencv_contrib
git checkout ${CV3_RELEASE}
mkdir -p /tmp/opencv-${CV3_RELEASE}-build
cd /tmp/opencv-${CV3_RELEASE}-build
cmake -DCMAKE_BUILD_TYPE=Release \
      -DWITH_CUDA=OFF \
      -DCMAKE_INSTALL_PREFIX=/usr/local/opencv-${CV3_RELEASE} \
      -DOPENCV_EXTRA_MODULES_PATH=/tmp/opencv_contrib/modules \
      /tmp/opencv
sudo make install -j

# clean up
rm -rf /tmp/opencv /tmp/opencv_contrib
sudo rm -rf /tmp/opencv-${CV2_RELEASE}-build /tmp/opencv-${CV3_RELEASE}-build
