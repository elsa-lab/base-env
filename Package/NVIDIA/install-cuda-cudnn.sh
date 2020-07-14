#!/usr/bin/env bash

# Cause the script to exit on any errors
# Reference: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail
set -euo pipefail

# useful variables
CUDA9_LINK="https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run"
CUDA9_INSTALLER="cuda_9.0.176_384.81_linux.run"
CUDA9_CUDNN7_LINK="http://developer.download.nvidia.com/compute/redist/cudnn/v7.3.1/cudnn-9.0-linux-x64-v7.3.1.20.tgz"
CUDA9_CUDNN7_TGZ="cudnn-9.0-linux-x64-v7.3.1.20.tgz"

CUDA10_LINK="https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda_10.0.130_410.48_linux"
CUDA10_INSTALLER="cuda_10.0.130_410.48_linux.run"
CUDA10_CUDNN7_LINK="http://developer.download.nvidia.com/compute/redist/cudnn/v7.5.0/cudnn-10.0-linux-x64-v7.5.0.56.tgz"
CUDA10_CUDNN7_TGZ="cudnn-10.0-linux-x64-v7.5.0.56.tgz"

CUDA10_1_LINK="http://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run"
CUDA10_1_INSTALLER="cuda_10.1.243_418.87.00_linux.run"
CUDA10_1_CUDNN7_LINK="http://developer.download.nvidia.com/compute/redist/cudnn/v7.6.0/cudnn-10.1-linux-x64-v7.6.0.64.tgz"
CUDA10_1_CUDNN7_TGZ="cudnn-10.1-linux-x64-v7.6.0.64.tgz"

CUDA10_2_LINK="http://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run"
CUDA10_2_INSTALLER="cuda_10.2.89_440.33.01_linux.run"
CUDA10_2_CUDNN7_LINK="http://developer.download.nvidia.com/compute/redist/cudnn/v7.6.5/cudnn-10.2-linux-x64-v7.6.5.32.tgz"
CUDA10_2_CUDNN7_TGZ="cudnn-10.2-linux-x64-v7.6.5.32.tgz"

TEMP_PATH="/tmp/cuda-$(date | md5sum | awk '{print $1}')"

# install function
install () {
  CUDA_VERSION=$1
  CUDNN_VERSION=$2
  CUDA_LINK=$3
  CUDA_INSTALLER=$4
  CUDNN_LINK=$5
  CUDNN_TGZ=$6

  # download cuda installer
  printf "Downlodaing CUDA ${CUDA_VERSION} installer... "
  curl -sSL "${CUDA_LINK}" -o "${CUDA_INSTALLER}"
  chmod +x "${CUDA_INSTALLER}"
  echo "Done."

  # download cudnn tgz
  printf "Downloading cuDNN ${CUDNN_VERSION} packages... "
  curl -sSL "${CUDNN_LINK}" -o "${CUDNN_TGZ}"
  echo "Done."

  # extends the sudo timeout for another 15 minutes
  sudo -v

  # install CUDA toolkit
  printf "Installing CUDA ${CUDA_VERSION}... "
  sudo ./"${CUDA_INSTALLER}" --silent --toolkit --override
  echo "Done."

  # install cuDNN library
  printf "Installing cuDNN ${CUDNN_VERSION}... "
  sudo tar --no-same-owner -xzf "${CUDNN_TGZ}" -C /usr/local
  echo "Done."

  # remove default symbloic link
  sudo rm -f /usr/local/cuda
}

# change directory to TEMP_PATH
mkdir -p "${TEMP_PATH}"
cd "${TEMP_PATH}"

# install each version of CUDA and cuDNN
install "9.0" "7.3.1" \
  "${CUDA9_LINK}" \
  "${CUDA9_INSTALLER}" \
  "${CUDA9_CUDNN7_LINK}" \
  "${CUDA9_CUDNN7_TGZ}"
install "10.0" "7.5.0" \
  "${CUDA10_LINK}" \
  "${CUDA10_INSTALLER}" \
  "${CUDA10_CUDNN7_LINK}" \
  "${CUDA10_CUDNN7_TGZ}"
install "10.1" "7.6.0" \
  "${CUDA10_1_LINK}" \
  "${CUDA10_1_INSTALLER}" \
  "${CUDA10_1_CUDNN7_LINK}" \
  "${CUDA10_1_CUDNN7_TGZ}"
install "10.2" "7.6.5" \
  "${CUDA10_2_LINK}" \
  "${CUDA10_2_INSTALLER}" \
  "${CUDA10_2_CUDNN7_LINK}" \
  "${CUDA10_2_CUDNN7_TGZ}"

# default use cuda-10.1
ln -fns /usr/local/cuda-10.1 ~/.cuda
sudo ln -fns /usr/local/cuda-10.1 /etc/skel/.cuda

# clean up
cd && rm -rf "${TEMP_PATH}"
