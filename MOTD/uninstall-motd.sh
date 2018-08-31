#!/bin/sh

# useful variables
MOTD_PATH="/etc/update-motd.d"
BIN_PATH="/usr/local/bin"

# extends the sudo timeout for another 15 minutes
sudo -v

# uninstall motds
sudo rm -f ${MOTD_PATH}/5* ${MOTD_PATH}/6*
sudo rm -f ${BIN_PATH}/*-status