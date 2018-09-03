#!/bin/sh

# extends the sudo timeout for another 15 minutes
sudo -v

# install Xfce desktop environment
sudo apt-get update
sudo apt-get install -y xfce4

# remove XScreenSaver, due to there is no real screen
sudo apt-get remove -y xscreensaver
sudo apt autoremove -y
