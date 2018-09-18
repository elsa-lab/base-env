#!/bin/sh

# useful variables
DRIVER_VERSION="384.81"
DRIVER_INSTALLER="NVIDIA-Linux-x86_64-${DRIVER_VERSION}.run"
DRIVER_LINK="http://us.download.nvidia.com/XFree86/Linux-x86_64/${DRIVER_VERSION}/${DRIVER_INSTALLER}"

# extends the sudo timeout for another 15 minutes
sudo -v

# install dkms first
sudo apt update
sudo apt install -y --reinstall dkms

# download installer to /tmp
cd /tmp
curl -L "${DRIVER_LINK}" -O
chmod +x "${DRIVER_INSTALLER}"

# stop lightdm
if service --status-all | grep -Fq 'lightdm'; then
  sudo service lightdm stop
fi

# install NVIDIA driver
sudo ./"${DRIVER_INSTALLER}" \
  --silent \
  --dkms \
  --no-opengl-files

# enable persistence mode
sudo /usr/bin/nvidia-smi -pm 1

# restart lightdm
if service --status-all | grep -Fq 'lightdm'; then
  sudo service lightdm restart
fi

# clean up
rm -f "${DRIVER_INSTALLER}"
