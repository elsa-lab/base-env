#!/bin/sh

# extends the sudo timeout for another 15 minutes
sudo -v

# disable default video driver
sudo sed -i \
  's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="nomodeset"/g' \
  /etc/default/grub
sudo update-grub

echo "Please Reboot Before Driver Installation"
