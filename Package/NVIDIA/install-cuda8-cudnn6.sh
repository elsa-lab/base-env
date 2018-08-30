#!/bin/sh

# useful variables
CUDA_INSTALLER="cuda_8.0.61_375.26_linux.run"
CUDA_LINK="https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run"
CUDNN_TGZ="cudnn-8.0-linux-x64-v6.0.tgz"
CUDNN_LINK="http://developer.download.nvidia.com/compute/redist/cudnn/v6.0/cudnn-8.0-linux-x64-v6.0.tgz"

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
curl -L "${CUDNN_LINK}" -O

# install cudnn library to cuda home
sudo tar --no-same-owner -xzf "${CUDNN_TGZ}" -C /usr/local

# clean up
rm -f "${CUDA_INSTALLER}"
rm -f "${CUDNN_TGZ}"
