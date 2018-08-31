#!/bin/sh

# extends the sudo timeout for another 15 minutes
sudo -v

# some env variables for bash
echo '
########## CUDA SECTION BEGIN ##########
export PATH="/usr/local/cuda/bin:${PATH}"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64"
export CUDA_HOME="/usr/local/cuda"
export CUDA_VISIBLE_DEVICES="0"
########## CUDA SECTION END ##########
' | sudo tee --append /etc/bash.bashrc

# enable persistence-mode on start up
sudo sed -i -e '$i /usr/bin/nvidia-smi -pm 1\n' /etc/rc.local
