#!/usr/bin/env bash

# Cause the script to exit on any errors
# Reference: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euo pipefail

# extends the sudo timeout for another 15 minutes
sudo -v

# update apt repo
sudo apt update

# install TigerVNC
sudo apt install -y tigervnc-standalone-server tigervnc-xorg-extension

# install web browser
sudo apt install -y firefox fonts-moe-standard-kai
