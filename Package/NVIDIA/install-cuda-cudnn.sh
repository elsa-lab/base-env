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

TEMP_PATH="/tmp/cuda-$(date | md5sum | awk '{print $1}')"

# change directory to TEMP_PATH
mkdir -p "${TEMP_PATH}"
cd "${TEMP_PATH}"

# download cuda installer
printf "Downloading cuda installer... "
curl -sSL "${CUDA9_LINK}" -o "${CUDA9_INSTALLER}"
curl -sSL "${CUDA10_LINK}" -o "${CUDA10_INSTALLER}"
curl -sSL "${CUDA10_1_LINK}" -o "${CUDA10_1_INSTALLER}"
chmod +x "${CUDA9_INSTALLER}"
chmod +x "${CUDA10_INSTALLER}"
chmod +x "${CUDA10_1_INSTALLER}"
echo "Done."

# download cudnn tgz
printf "Downloading cuDNN packages... "
curl -sSLO "${CUDA9_CUDNN7_LINK}"
curl -sSLO "${CUDA10_CUDNN7_LINK}"
curl -sSLO "${CUDA10_1_CUDNN7_LINK}"
echo "Done."

# extends the sudo timeout for another 15 minutes
sudo -v

# install cuda9 toolkit
sudo ./"${CUDA9_INSTALLER}" --silent --toolkit --override
sudo tar --no-same-owner -xzf "${CUDA9_CUDNN7_TGZ}" -C /usr/local

# install cuda10 toolkit
sudo ./"${CUDA10_INSTALLER}" --silent --toolkit --override
sudo tar --no-same-owner -xzf "${CUDA10_CUDNN7_TGZ}" -C /usr/local

# install cuda10.1 toolkit
sudo ./"${CUDA10_1_INSTALLER}" --silent --toolkit --override
sudo tar --no-same-owner -xzf "${CUDA10_1_CUDNN7_TGZ}" -C /usr/local

# remove default symbloic link
sudo rm -f /usr/local/cuda

# default use cuda-10.1
ln -fns /usr/local/cuda-10.1 ~/.cuda
sudo ln -fns /usr/local/cuda-10.1 /etc/skel/.cuda

# clean up
cd && rm -rf "${TEMP_PATH}"
