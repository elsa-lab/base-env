#!/bin/sh

# useful variables
CUDA8_LINK="https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda_8.0.61_375.26_linux-run"
CUDA9_LINK="https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run"

CUDA8_CUDNN5_LINK="http://developer.download.nvidia.com/compute/redist/cudnn/v5.1/cudnn-8.0-linux-x64-v5.1.tgz"
CUDA8_CUDNN6_LINK="http://developer.download.nvidia.com/compute/redist/cudnn/v6.0/cudnn-8.0-linux-x64-v6.0.tgz"
CUDA8_CUDNN7_LINK="http://developer.download.nvidia.com/compute/redist/cudnn/v7.1.2/cudnn-8.0-linux-x64-v7.1.tgz"
CUDA9_CUDNN7_LINK="http://developer.download.nvidia.com/compute/redist/cudnn/v7.3.1/cudnn-9.0-linux-x64-v7.3.1.20.tgz"

CUDA8_INSTALLER="cuda_8.0.61_375.26_linux.run"
CUDA9_INSTALLER="cuda_9.0.176_384.81_linux.run"

CUDA8_CUDNN5_TGZ="cudnn-8.0-linux-x64-v5.1.tgz"
CUDA8_CUDNN6_TGZ="cudnn-8.0-linux-x64-v6.0.tgz"
CUDA8_CUDNN7_TGZ="cudnn-8.0-linux-x64-v7.1.tgz"
CUDA9_CUDNN7_TGZ="cudnn-9.0-linux-x64-v7.3.1.20.tgz"

TEMP_PATH="/tmp/cuda-$(date | md5sum | awk '{print $1}')"

# change directory to TEMP_PATH
mkdir -p "${TEMP_PATH}"
cd "${TEMP_PATH}"

# download cuda installer
curl -L "${CUDA8_LINK}" -o "${CUDA8_INSTALLER}"
curl -L "${CUDA9_LINK}" -o "${CUDA9_INSTALLER}"
chmod +x "${CUDA8_INSTALLER}"
chmod +x "${CUDA9_INSTALLER}"

# download cudnn tgz
curl -LO "${CUDA8_CUDNN5_LINK}"
curl -LO "${CUDA8_CUDNN6_LINK}"
curl -LO "${CUDA8_CUDNN7_LINK}"
curl -LO "${CUDA9_CUDNN7_LINK}"

# extends the sudo timeout for another 15 minutes
sudo -v

# install cuda8 toolkit
sudo ./"${CUDA8_INSTALLER}" --silent --toolkit --verbose

# install cudnn library to cuda8 home
sudo tar --no-same-owner -xzf "${CUDA8_CUDNN5_TGZ}" -C /usr/local --wildcards 'cuda/lib64/libcudnn.so.*'
sudo tar --no-same-owner -xzf "${CUDA8_CUDNN6_TGZ}" -C /usr/local --wildcards 'cuda/lib64/libcudnn.so.*'
sudo tar --no-same-owner -xzf "${CUDA8_CUDNN7_TGZ}" -C /usr/local --wildcards 'cuda/lib64/libcudnn.so.*'

# install cuda9 toolkit
sudo ./"${CUDA9_INSTALLER}" --silent --toolkit --verbose

# install cudnn library to cuda9 home
sudo tar --no-same-owner -xzf "${CUDA9_CUDNN7_TGZ}" -C /usr/local --wildcards 'cuda/lib64/libcudnn.so.*'

# remove default symbloic link
sudo rm -f /usr/local/cuda

# some env variables for bash
echo '
export CUDA_DEVICE_ORDER=PCI_BUS_ID
export CUDA_HOME="${HOME}/.cuda"
export PATH="${CUDA_HOME}/bin:${PATH}"
export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:${CUDA_HOME}/extras/CUPTI/lib64:${LD_LIBRARY_PATH}"
export CUDA_VISIBLE_DEVICES="0"
' | sudo tee /etc/profile.d/cuda.sh

# default use cuda-9.0
ln -n -f -s /usr/local/cuda-9.0 ~/.cuda
sudo ln -n -f -s /usr/local/cuda-9.0 /etc/skel/.cuda

# clean up
cd && rm -rf "${TEMP_PATH}"
