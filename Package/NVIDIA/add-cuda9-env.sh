#!/bin/sh

# extends the sudo timeout for another 15 minutes
sudo -v

# some env variables for bash
echo '
########## CUDA SECTION BEGIN ##########
export CUDA_HOME="/usr/local/cuda-9.0"
export PATH="${CUDA_HOME}/bin:${PATH}"
export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:${CUDA_HOME}/extras/CUPTI/lib64"
export CUDA_VISIBLE_DEVICES="0"
########## CUDA SECTION END ##########
' | sudo tee /etc/profile.d/cuda.sh
