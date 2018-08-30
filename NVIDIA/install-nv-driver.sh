#!/bin/sh

# useful variables
DRIVER_VERSION="390.67"
DRIVER_INSTALLER="NVIDIA-Linux-x86_64-${DRIVER_VERSION}.run"
DRIVER_LINK="http://us.download.nvidia.com/XFree86/Linux-x86_64/${DRIVER_VERSION}/${DRIVER_INSTALLER}"

# extends the sudo timeout for another 15 minutes
sudo -v

# install dkms first
sudo apt install -y dkms

# download installer to /tmp
cd /tmp
curl -L "${DRIVER_LINK}" -O
chmod +x "${DRIVER_INSTALLER}"

# stop lightdm
sudo service lightdm stop

# install NVIDIA driver
sudo ./"${DRIVER_INSTALLER}" \
  --silent \
  --dkms \
  --no-opengl-files

# enable persistence mode
# you can also add this functionality to /etc/rc.local
sudo /usr/bin/nvidia-smi -pm 1

# restart lightdm
sudo service lightdm restart

# clean up
rm -f "${DRIVER_INSTALLER}"
