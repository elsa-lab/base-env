#!/usr/bin/env bash

# Cause the script to exit on any errors
# Reference: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euo pipefail

# useful variables
MJ_VERSIONS="210"

LINK_PREFIX="https://mujoco.org/download"
LINK_POSTFIX="-linux-x86_64.tar.gz"

MJ_PATH="/usr/local/mujoco"
TEMP_PATH="/tmp/mujoco-$(date | md5sum | awk '{print $1}')"

# extends the sudo timeout for another 15 minutes
sudo -v

# change directory to TEMP_PATH
mkdir -p "${TEMP_PATH}"
cd "${TEMP_PATH}"

# download zipfiles of mujoco
for v in ${MJ_VERSIONS}; do
  curl -sSLO "${LINK_PREFIX}/mujoco${v}${LINK_POSTFIX}"
done

# untar mujoco then clean the tar ball
for tar in *.tar.gz; do
  tar -xf "${tar}"
  rm "${tar}"
done

# extends the sudo timeout for another 15 minutes
sudo -v

# install mujoco to MJ_PATH
sudo cp -r * "${MJ_PATH}"

# clean up
cd && rm -rf "${TEMP_PATH}"

