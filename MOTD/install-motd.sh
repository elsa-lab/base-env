#!/bin/sh

# useful variables
MOTD_PATH="/etc/update-motd.d"
BIN_PATH="/usr/local/bin"

# extends the sudo timeout for another 15 minutes
sudo -v

# install motds
sudo cp motds/50-landscape-sysinfo "${MOTD_PATH}/"
sudo cp motds/51-hdd-status "${MOTD_PATH}/"
sudo cp motds/54-hst-status "${MOTD_PATH}/"
sudo cp motds/55-command-description "${MOTD_PATH}/"
sudo cp motds/56-ssh-banner-short "${MOTD_PATH}/"
sudo cp motds/59-news "${MOTD_PATH}/"
sudo cp motds/60-newline "${MOTD_PATH}/"

sudo ln -s /etc/update-motd.d/51-hdd-status "${BIN_PATH}/hdd-status"
sudo ln -s /etc/update-motd.d/54-hst-status "${BIN_PATH}/hst-status"

type nvidia-smi > /dev/null
if [ $? -eq 0 ]; then
  sudo cp motds/52-gpu-status "${MOTD_PATH}/"
  sudo ln -s /etc/update-motd.d/52-gpu-status "${BIN_PATH}/gpu-status"
fi

type vncserver > /dev/null
if [ $? -eq 0 ]; then
  sudo cp motds/53-vnc-status "${MOTD_PATH}/"
  sudo ln -s /etc/update-motd.d/53-vnc-status "${BIN_PATH}/vnc-status"
fi

# enable useful info
sudo chmod go+rx /etc/update-motd.d/5*
sudo chmod go+rx /etc/update-motd.d/6*

# disable useless info
sudo chmod -x /etc/update-motd.d/1*
sudo chmod -x /etc/update-motd.d/9* 
