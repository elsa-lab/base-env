#!/bin/sh

# useful variables
CUDA_INSTALLER="cuda_9.0.176_384.81_linux.run"
CUDA_LINK="https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run"
CUDNN7_TGZ="cudnn-9.0-linux-x64-v7.2.1.38.tgz"
CUDNN7_LINK="http://developer.download.nvidia.com/compute/redist/cudnn/v7.2.1/cudnn-9.0-linux-x64-v7.2.1.38.tgz"

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
curl -L "${CUDNN7_LINK}" -O

# install cudnn library to cuda home
sudo tar --no-same-owner -xzf "${CUDNN7_TGZ}" -C /usr/local --wildcards 'cuda/lib64/libcudnn.so.*'

# remove symbloic link
sudo rm -f /usr/local/cuda

# clean up
rm -f "${CUDA_INSTALLER}"
rm -f "${CUDNN7_TGZ}"
