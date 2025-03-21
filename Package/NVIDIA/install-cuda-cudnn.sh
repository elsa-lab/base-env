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

  # download cudnn tgz / tar.xz
  printf "Downloading cuDNN ${CUDNN_VERSION} packages... "
  if [[ "${CUDNN_LINK}" == *.tgz ]]
  then
      CUDNN_FILE="cudnn.tgz"
  elif [[ "${CUDNN_LINK}" == *.tar.xz ]]
  then
      CUDNN_FILE="cudnn.tar.xz"
  fi
  
  if [[ "${CUDNN_LINK}" == http* ]]
  then
      curl -sSL "${CUDNN_LINK}" -o "${CUDNN_FILE}"
  else
      scp -i ~/.ssh/elsa-server "$(logname)@elsa.cs.nthu.edu.tw:/data_10T/install_archive/${CUDNN_LINK}" "${CUDNN_FILE}"
  fi
      
  echo "Done."

  # extends the sudo timeout for another 15 minutes
  sudo -v

  # install CUDA toolkit
  printf "Installing CUDA ${CUDA_VERSION}... "
  sudo ./cuda.run --silent --toolkit --override
  echo "Done."

  # install cuDNN library
  printf "Installing cuDNN ${CUDNN_VERSION}... "
  if [[ "${CUDNN_FILE}" == *.tgz ]]
  then
      sudo tar --no-same-owner -xzf "${CUDNN_FILE}" -C /usr/local
  elif [[ "${CUDNN_FILE}" == *.tar.xz ]]
  then
      sudo tar --no-same-owner -xf "${CUDNN_FILE}"
      sudo cp cudnn-*-archive/include/cudnn*.h /usr/local/cuda/include
      sudo cp -P cudnn-*-archive/lib/libcudnn* /usr/local/cuda/lib64
      sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
      sudo rm -r cudnn-*-archive
  fi
  echo "Done."

  # remove default symbloic link
  sudo rm /usr/local/cuda

  # clean up
  rm cuda.run "${CUDNN_FILE}"
}

# install each version of CUDA and cuDNN

# install "9.0.176" "7.3.1" \
#   "https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run" \
#   "http://developer.download.nvidia.com/compute/redist/cudnn/v7.3.1/cudnn-9.0-linux-x64-v7.3.1.20.tgz"
# install "10.0.130" "7.5.0" \
#   "https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda_10.0.130_410.48_linux" \
#   "http://developer.download.nvidia.com/compute/redist/cudnn/v7.5.0/cudnn-10.0-linux-x64-v7.5.0.56.tgz"
# install "10.1" "7.6.0" \
#   "http://developer.download.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda_10.1.243_418.87.00_linux.run" \
#   "http://developer.download.nvidia.com/compute/redist/cudnn/v7.6.0/cudnn-10.1-linux-x64-v7.6.0.64.tgz"
install "10.2" "7.6.5" \
  "http://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run" \
  "http://developer.download.nvidia.com/compute/redist/cudnn/v7.6.5/cudnn-10.2-linux-x64-v7.6.5.32.tgz"

# install "11.0" "8.0.4" \
#   "http://developer.download.nvidia.com/compute/cuda/11.0.2/local_installers/cuda_11.0.2_450.51.05_linux.run" \
#   "http://developer.download.nvidia.com/compute/redist/cudnn/v8.0.4/cudnn-11.0-linux-x64-v8.0.4.30.tgz"
# install "11.1.1" "8.0.5" \
#   "https://developer.download.nvidia.com/compute/cuda/11.1.1/local_installers/cuda_11.1.1_455.32.00_linux.run" \
#   "http://developer.download.nvidia.com/compute/redist/cudnn/v8.0.5/cudnn-11.1-linux-x64-v8.0.5.39.tgz"
# install "11.2.2" "8.1.1" \
#   "https://developer.download.nvidia.com/compute/cuda/11.2.2/local_installers/cuda_11.2.2_460.32.03_linux.run" \
#   "http://developer.download.nvidia.com/compute/redist/cudnn/v8.1.1/cudnn-11.2-linux-x64-v8.1.1.33.tgz"
 
# install "11.3" "8.6.0" \
#   "https://developer.download.nvidia.com/compute/cuda/11.3.1/local_installers/cuda_11.3.1_465.19.01_linux.run" \
#   "https://developer.download.nvidia.com/compute/redist/cudnn/v8.6.0/local_installers/11.8/cudnn-linux-x86_64-8.6.0.163_cuda11-archive.tar.xz"
install "11.6" "8.6.0" \
  "https://developer.download.nvidia.com/compute/cuda/11.6.2/local_installers/cuda_11.6.2_510.47.03_linux.run" \
  "https://developer.download.nvidia.com/compute/redist/cudnn/v8.6.0/local_installers/11.8/cudnn-linux-x86_64-8.6.0.163_cuda11-archive.tar.xz"
# install "11.7" "8.6.0" \
#   "https://developer.download.nvidia.com/compute/cuda/11.7.1/local_installers/cuda_11.7.1_515.65.01_linux.run" \
#   "https://developer.download.nvidia.com/compute/redist/cudnn/v8.6.0/local_installers/11.8/cudnn-linux-x86_64-8.6.0.163_cuda11-archive.tar.xz"
install "11.8" "8.6.0" \
  "https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda_11.8.0_520.61.05_linux.run" \
  "https://developer.download.nvidia.com/compute/redist/cudnn/v8.6.0/local_installers/11.8/cudnn-linux-x86_64-8.6.0.163_cuda11-archive.tar.xz"

# install "12.0" "8.9.6" \
#   "https://developer.download.nvidia.com/compute/cuda/12.0.1/local_installers/cuda_12.0.1_525.85.12_linux.run" \
#   "cudnn-linux-x86_64-8.9.6.50_cuda12-archive.tar.xz"
install "12.1" "8.9.6" \
  "https://developer.download.nvidia.com/compute/cuda/12.1.1/local_installers/cuda_12.1.1_530.30.02_linux.run" \
  "cudnn-linux-x86_64-8.9.6.50_cuda12-archive.tar.xz"
# install "12.2" "8.9.6" \
#   "https://developer.download.nvidia.com/compute/cuda/12.2.1/local_installers/cuda_12.2.1_535.86.10_linux.run" \
#   "cudnn-linux-x86_64-8.9.6.50_cuda12-archive.tar.xz"
install "12.4" "8.9.7" \

  "https://developer.download.nvidia.com/compute/cuda/12.4.1/local_installers/cuda_12.4.1_550.54.15_linux.run" \
  "cudnn-linux-x86_64-8.9.7.29_cuda12-archive.tar.xz"

# default use cuda-11.6
ln -fns /usr/local/cuda-11.6 ~/.cuda
sudo ln -fns /usr/local/cuda-11.6 /etc/skel/.cuda

