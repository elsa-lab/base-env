#!/usr/bin/env bash

# Cause the script to exit on any errors
# Reference: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euo pipefail

# extends the sudo timeout for another 15 minutes
sudo -v

# update apt repo
sudo apt update

# install TigerVNC
sudo apt instal -y tigervnc-standalone-server tigervnc-xorg-extension

# install web browser
sudo apt install -y firefox fonts-moe-standard-kai

# install visual studio code
curl -L 'https://go.microsoft.com/fwlink/?LinkID=760868' -o /tmp/vs-code.deb
sudo dpkg -i /tmp/vs-code.deb

# clean up
rm -f /tmp/vs-code.deb
