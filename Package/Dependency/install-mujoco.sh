#!/bin/bash

# Cause the script to exit on any errors
# Reference: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euo pipefail

# useful variables
MJPRO_VERSIONS="131 140 150"
MJ_VERSIONS="200"

LINK_PREFIX="https://www.roboti.us/download"
LINK_POSTFIX="_linux.zip"

MJ_PATH="/usr/local/mujoco"
TEMP_PATH="/tmp/mujoco-$(date | md5sum | awk '{print $1}')"

# change directory to TEMP_PATH
mkdir -p "${TEMP_PATH}"
cd "${TEMP_PATH}"

# download getid
curl -sSLO "https://www.roboti.us/getid/getid_linux"
chmod +x getid_linux

# download zipfiles of mujoco
for v in ${MJPRO_VERSIONS}; do
  curl -sSLO "${LINK_PREFIX}/mjpro${v}${LINK_POSTFIX}"
done

for v in ${MJ_VERSIONS}; do
  curl -sSLO "${LINK_PREFIX}/mujoco${v}${LINK_POSTFIX}"
done

# unzip mujoco then clean the zipfile
for z in *.zip; do
  unzip "${z}"
  rm "${z}"
done

# rename mujoco200
ln -fsn mujoco200_linux mujoco200

# extends the sudo timeout for another 15 minutes
sudo -v

# install mujoco to MJ_PATH
sudo mkdir -p "${MJ_PATH}"
sudo cp -r * "${MJ_PATH}"

# make symbolic link to home
ln -fsn "${MJ_PATH}" "${HOME}/.mujoco"
sudo ln -fsn "${MJ_PATH}" "/etc/skel/.mujoco"

# clean up
cd && rm -rf "${TEMP_PATH}"

# install PatchELF (for mujoco-py)
# sudo add-apt-repository -y ppa:jamesh/snap-support
# sudo apt-get update
# sudo apt-get install -y patchelf
