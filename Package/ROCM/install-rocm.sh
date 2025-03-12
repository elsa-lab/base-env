#!/usr/bin/env bash

# Cause the script to exit on any errors
# Reference: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail
set -euo pipefail

# change to /tmp
cd /tmp


UBUNTU_CODENAME=$(lsb_release -cs)
ROCM_VERS="6.3.3 6.2.4"

# Add the ROCm repositories
printf "Registering ROCm repositories ..."
for ROCM_VER in $ROCM_VERS; do
  echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/rocm.gpg] https://repo.radeon.com/rocm/apt/${ROCM_VER} ${UBUNTU_CODENAME} main" \
      | sudo tee --append /etc/apt/sources.list.d/rocm.list
done
echo -e 'Package: *\nPin: release o=repo.radeon.com\nPin-Priority: 600' \
    | sudo tee /etc/apt/preferences.d/rocm-pin-600
echo "Done."

# Install ROCm
printf "Installing ROCm ..."
sudo apt update
for ROCM_VER in $ROCM_VERS; do
  # extends the sudo timeout for another minutes
  sudo -v 

  printf "Installing ROCm ${ROCM_VER} ..."
  sudo amdgpu-install -y --usecase=rocm --rocmrelease=${ROCM_VER}
  echo "ROCm ${ROCM_VER} installed."
done
echo "Done."


# Default version
ln -fns /opt/rocm-6.2.4 ~/.rocm
sudo ln -fns /opt/rocm-6.2.4 /etc/skel/.rocm

