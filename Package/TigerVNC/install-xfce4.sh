#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# Cause the script to exit on any errors
# Reference: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euo pipefail

# extends the sudo timeout for another 15 minutes
sudo -v

# install Xfce desktop environment
sudo apt update
sudo apt install -y --no-install-recommends xfce4 xfce4-goodies

# purge display manager
sudo apt purge -y gdm3 lightdm

# remove XScreenSaver, due to there is no real screen
sudo apt purge -y xscreensaver

# remove xdg-user-dirs, since we dont need those default dirs
sudo apt purge -y xdg-user-dirs

# clean up
sudo apt autoremove -y --purge
