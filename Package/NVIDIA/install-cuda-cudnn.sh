#!/bin/sh

# useful variables
CUDA9_LINK="https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run"
CUDA9_CUDNN7_LINK="http://developer.download.nvidia.com/compute/redist/cudnn/v7.3.1/cudnn-9.0-linux-x64-v7.3.1.20.tgz"

CUDA9_INSTALLER="cuda_9.0.176_384.81_linux.run"
CUDA9_CUDNN7_TGZ="cudnn-9.0-linux-x64-v7.3.1.20.tgz"

TEMP_PATH="/tmp/cuda-$(date | md5sum | awk '{print $1}')"

# change directory to TEMP_PATH
mkdir -p "${TEMP_PATH}"
cd "${TEMP_PATH}"

# download cuda installer
curl -L "${CUDA9_LINK}" -o "${CUDA9_INSTALLER}"
chmod +x "${CUDA9_INSTALLER}"

# download cudnn tgz
curl -LO "${CUDA9_CUDNN7_LINK}"

# extends the sudo timeout for another 15 minutes
sudo -v

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
