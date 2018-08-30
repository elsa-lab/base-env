#!/bin/sh

echo '
########## CUDA SECTION BEGIN ##########
export PATH="/usr/local/cuda/bin:${PATH}"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64"
export CUDA_HOME="/usr/local/cuda"
export CUDA_VISIBLE_DEVICES="0"
########## CUDA SECTION END ##########
' | sudo tee --append /etc/bash.bashrc
