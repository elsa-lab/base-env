#!/bin/sh

# useful variables
CUDA_INSTALLER="cuda_9.0.176_384.81_linux.run"
CUDA_LINK="https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run"
CUDNN_TGZ="cudnn-9.0-linux-x64-v7.2.1.38.tgz"
CUDNN_LINK="http://developer.download.nvidia.com/compute/redist/cudnn/v7.2.1/cudnn-9.0-linux-x64-v7.2.1.38.tgz"

# download cuda installer to /tmp
cd /tmp
curl -L "${CUDA_LINK}" -o "${CUDA_INSTALLER}"
chmod +x "${CUDA_INSTALLER}"

# install cuda toolkit
sudo -v
sudo ./"${CUDA_INSTALLER}" \
  --silent \
  --toolkit

# download cudnn tgz to /tmp
cd /tmp
curl -L "${CUDNN_LINK}" -O

# install cudnn library to cuda home
sudo tar --no-same-owner -xzf ${CUDNN_TGZ} -C /usr/local

# clean up
rm -f ${CUDA_INSTALLER}
rm -f ${CUDNN_TGZ}
