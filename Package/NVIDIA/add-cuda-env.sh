#!/bin/sh

# extends the sudo timeout for another 15 minutes
sudo -v

# some env variables for bash
echo '
export CUDA_HOME="${HOME}/.cuda"
export PATH="${CUDA_HOME}/bin:${PATH}"
export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:${CUDA_HOME}/extras/CUPTI/lib64"
export CUDA_VISIBLE_DEVICES="0"
' | sudo tee /etc/profile.d/cuda.sh

# default use cuda-9.0
ln -s /usr/local/cuda-9.0 ~/.cuda
sudo ln -s /usr/local/cuda-9.0 /etc/skel/.cuda
