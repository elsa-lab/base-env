#!/usr/bin/env bash

# Cause the script to exit on any errors
# Reference: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euo pipefail

# extends the sudo timeout for another 15 minutes
sudo -v

# install Xfce desktop environment
sudo apt-get update
sudo apt-get install -y xfce4 xfce4-goodies

# remove XScreenSaver, due to there is no real screen
sudo apt-get purge -y xscreensaver

# remove xdg-user-dirs, since we dont need those default dirs
sudo apt-get purge -y xdg-user-dirs

# clean up
sudo apt-get autoremove -y --purge
