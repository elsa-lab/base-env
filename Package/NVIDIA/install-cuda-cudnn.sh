#!/usr/bin/env bash

# Cause the script to exit on any errors
# Reference: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail
set -euo pipefail

# change to /tmp
cd /tmp

# install function
install () {
  CUDA_VERSION=$1
  CUDNN_VERSION=$2
  CUDA_LINK=$3
  CUDNN_LINK=$4

  # download cuda installer
  printf "Downlodaing CUDA ${CUDA_VERSION} installer... "
  curl -sSL "${CUDA_LINK}" -o cuda.run
  chmod +x cuda.run
  echo "Done."

  # download cudnn tgz
  printf "Downloading cuDNN ${CUDNN_VERSION} packages... "
  curl -sSL "${CUDNN_LINK}" -o cudnn.tgz
  echo "Done."

  # extends the sudo timeout for another 15 minutes
  sudo -v

  # install CUDA toolkit
  printf "Installing CUDA ${CUDA_VERSION}... "
  sudo ./cuda.run --silent --toolkit --override
  echo "Done."

  # install cuDNN library
  printf "Installing cuDNN ${CUDNN_VERSION}... "
  sudo tar --no-same-owner -xzf cudnn.tgz -C /usr/local
  echo "Done."

  # remove default symbloic link
  sudo rm /usr/local/cuda

  # clean up
  rm cuda.run cudnn.tgz
}

# install each version of CUDA and cuDNN
install "9.0.176" "7.3.1" \
  "https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run" \
  "http://developer.download.nvidia.com/compute/redist/cudnn/v7.3.1/cudnn-9.0-linux-x64-v7.3.1.20.tgz"
install "10.0.130" "7.5.0" \
  "https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda_10.0.130_410.48_linux" \
  "http://developer.download.nvidia.com/compute/redist/cudnn/v7.5.0/cudnn-10.0-linux-x64-v7.5.0.56.tgz"
install "10.1" "7.6.0" \
  "http://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run" \
  "http://developer.download.nvidia.com/compute/redist/cudnn/v7.6.0/cudnn-10.1-linux-x64-v7.6.0.64.tgz"
install "10.2" "7.6.5" \
  "http://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run" \
  "http://developer.download.nvidia.com/compute/redist/cudnn/v7.6.5/cudnn-10.2-linux-x64-v7.6.5.32.tgz"
install "11.0" "8.0.4" \
  "http://developer.download.nvidia.com/compute/cuda/11.0.2/local_installers/cuda_11.0.2_450.51.05_linux.run" \
  "http://developer.download.nvidia.com/compute/redist/cudnn/v8.0.4/cudnn-11.0-linux-x64-v8.0.4.30.tgz"
install "11.1.1" "8.0.5" \
  "https://developer.download.nvidia.com/compute/cuda/11.1.1/local_installers/cuda_11.1.1_455.32.00_linux.run" \
  "http://developer.download.nvidia.com/compute/redist/cudnn/v8.0.5/cudnn-11.1-linux-x64-v8.0.5.39.tgz"
install "11.2.2" "8.1.1" \
  "https://developer.download.nvidia.com/compute/cuda/11.2.2/local_installers/cuda_11.2.2_460.32.03_linux.run" \
  "http://developer.download.nvidia.com/compute/redist/cudnn/v8.1.1/cudnn-11.2-linux-x64-v8.1.1.33.tgz"

# install cuda >= 11.3
install_new() {
  CUDA_VERSION=$1
  CUDNN_VERSION=$2
  CUDA_LINK=$3
  CUDNN_LINK=$4

  # download cuda installer
  printf "Downlodaing CUDA ${CUDA_VERSION} installer... "
  curl -sSL "${CUDA_LINK}" -o cuda.run
  chmod +x cuda.run
  echo "Done."

  # download cudnn tar.xz
  printf "Downlodaing cuDNN ${CUDNN_VERSION} installer... "
  curl -sSL "${CUDNN_LINK}" -o cudnn.tar.xz
  echo "Done."

  sudo -v

  printf "Installing CUDA ${CUDA_VERSION}..."
  sudo ./cuda.run --silent --toolkit --override
  echo "Done."

  # follow the instructions from https://docs.nvidia.com/deplearning/cudnn/install-guide/index.html#installlinux-tar
  printf "Installing cuDNN ${CUDNN_VERSION}..."
  sudo tar --no-same-owner -xf cudnn.tar.xz
  sudo cp cudnn-*-archive/include/cudnn*.h /usr/local/cuda/include
  sudo cp -P cudnn-*-archive/lib/libcudnn* /usr/local/cuda/lib64
  sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
  echo "Done."

  sudo rm /usr/local/cuda
  sudo rm cuda.run cudnn.tar.xz
  sudo rm -r cudnn-*-archive
}

install_new "11.3" "8.7.0" \
  "https://developer.download.nvidia.com/compute/cuda/11.3.1/local_installers/cuda_11.3.1_465.19.01_linux.run" \
  "https://developer.download.nvidia.com/compute/redist/cudnn/v8.7.0/local_installers/11.8/cudnn-linux-x86_64-8.7.0.84_cuda11-archive.tar.xz"

install_new "11.6" "8.7.0" \
  "https://developer.download.nvidia.com/compute/cuda/11.6.2/local_installers/cuda_11.6.2_510.47.03_linux.run" \
  "https://developer.download.nvidia.com/compute/redist/cudnn/v8.7.0/local_installers/11.8/cudnn-linux-x86_64-8.7.0.84_cuda11-archive.tar.xz"


# default use cuda-11.2
ln -fns /usr/local/cuda-11.2 ~/.cuda
sudo ln -fns /usr/local/cuda-11.2 /etc/skel/.cuda

