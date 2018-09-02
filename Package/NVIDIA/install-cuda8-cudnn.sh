#!/bin/sh

# useful variables
CUDA_INSTALLER="cuda_8.0.61_375.26_linux.run"
CUDA_LINK="https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run"
CUDNN5_TGZ="cudnn-8.0-linux-x64-v5.1.tgz"
CUDNN5_LINK="http://developer.download.nvidia.com/compute/redist/cudnn/v5.1/cudnn-8.0-linux-x64-v5.1.tgz"
CUDNN6_TGZ="cudnn-8.0-linux-x64-v6.0.tgz"
CUDNN6_LINK="http://developer.download.nvidia.com/compute/redist/cudnn/v6.0/cudnn-8.0-linux-x64-v6.0.tgz"
CUDNN7_TGZ="cudnn-8.0-linux-x64-v7.1.tgz"
CUDNN7_LINK="http://developer.download.nvidia.com/compute/redist/cudnn/v7.1.2/cudnn-8.0-linux-x64-v7.1.tgz"

# download cuda installer to /tmp
cd /tmp
curl -L "${CUDA_LINK}" -o "${CUDA_INSTALLER}"
chmod +x "${CUDA_INSTALLER}"

# extends the sudo timeout for another 15 minutes
sudo -v

# install cuda toolkit
sudo ./"${CUDA_INSTALLER}" \
  --silent \
  --toolkit

# download cudnn tgz to /tmp
cd /tmp
curl -L "${CUDNN5_LINK}" -O
curl -L "${CUDNN6_LINK}" -O
curl -L "${CUDNN7_LINK}" -O

# install cudnn library to cuda home
sudo tar --no-same-owner -xzf "${CUDNN5_TGZ}" -C /usr/local --wildcards 'cuda/lib64/libcudnn.so.*'
sudo tar --no-same-owner -xzf "${CUDNN6_TGZ}" -C /usr/local --wildcards 'cuda/lib64/libcudnn.so.*'
sudo tar --no-same-owner -xzf "${CUDNN7_TGZ}" -C /usr/local --wildcards 'cuda/lib64/libcudnn.so.*'

# remove symbloic link
sudo rm -f /usr/local/cuda

# clean up
rm -f "${CUDA_INSTALLER}"
rm -f "${CUDNN5_TGZ}"
rm -f "${CUDNN6_TGZ}"
rm -f "${CUDNN7_TGZ}"
