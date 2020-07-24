#!/usr/bin/env bash

# Cause the script to exit on any errors
# Reference: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail
set -euo pipefail

# change to /tmp
cd /tmp

# useful variables
DRIVER_VERSION="440.100" # CUDA Version: 10.2
DRIVER_INSTALLER="NVIDIA-Linux-x86_64-${DRIVER_VERSION}.run"
DRIVER_LINK="http://us.download.nvidia.com/XFree86/Linux-x86_64/${DRIVER_VERSION}/${DRIVER_INSTALLER}"

# extends the sudo timeout for another 15 minutes
sudo -v

# download installer
printf "Downlodaing NVIDIA driver ${DRIVER_VERSION} installer... "
curl -sSL "${DRIVER_LINK}" -o "${DRIVER_INSTALLER}"
chmod +x "${DRIVER_INSTALLER}"
echo "Done."

# stop lightdm
if service --status-all | grep -Fq 'lightdm'; then
  printf "Stopping lightdm... "
  sudo service lightdm stop
  echo "Done."
fi

# install NVIDIA driver
printf "Installing NVIDIA driver ${DRIVER_VERSION}... "
sudo ./"${DRIVER_INSTALLER}" --silent --dkms --no-opengl-files
echo "Done."

# enable persistence mode
sudo /usr/bin/nvidia-smi -pm 1

# enable persistence-mode on start up
if ! grep -q "nvidia-smi" /etc/rc.local; then
  if [ ! -f /etc/rc.local ]; then
    echo '#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

exit 0' | sudo tee /etc/rc.local
    sudo chmod +x /etc/rc.local
  fi
  sudo sed -i -e '$i /usr/bin/nvidia-smi -pm 1\n' /etc/rc.local
fi

# restart lightdm
if service --status-all | grep -Fq 'lightdm'; then
  printf "Restarting lightdm... "
  sudo service lightdm restart
  echo "Done."
fi

# clean up
rm "${DRIVER_INSTALLER}"

