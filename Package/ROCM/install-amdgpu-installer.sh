#!/usr/bin/env bash

# Cause the script to exit on any errors
# Reference: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail
set -euo pipefail

# change to /tmp
cd /tmp

# useful variables
UBUNTU_CODENAME=$(lsb_release -cs) # Ubuntu codename: noble (24.04)
AMDGPU_VERSION="6.3.3" # ROCm Version: 6.3.3
AMDGPU_INSTALLER="amdgpu-install_6.3.60303-1_all.deb"
AMDGPU_LINK="https://repo.radeon.com/amdgpu-install/${AMDGPU_VERSION}/ubuntu/${UBUNTU_CODENAME}/$AMDGPU_INSTALLER"

# extends the sudo timeout for another 15 minutes
sudo -v

# Use the amdgpu-installer script from the latest ROCm release you want to install
printf "Downloading AMDGPU-installer ${AMDGPU_VERSION} ... "
wget $AMDGPU_LINK
echo "Done."

# Install AMDGPU-installer
printf "Installing AMDGPU-installer ${AMDGPU_VERSION}... "
sudo apt update
sudo apt install -y ./"${AMDGPU_INSTALLER}"
sudo apt update
echo "Done."

# Verify the kernel-mode driver installation.
# dkms status

# clean up 
rm "${AMDGPU_INSTALLER}"
