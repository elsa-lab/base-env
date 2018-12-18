#!/bin/sh

# extends the sudo timeout for another 15 minutes
sudo -v

# install Xfce desktop environment
sudo apt-get update
sudo apt-get install -y xfce4 xfce4-goodies

# install TigerVNC
sudo apt-get install -y tigervnc-standalone-server tigervnc-xorg-extension

# remove XScreenSaver, due to there is no real screen
sudo apt-get purge -y xscreensaver

# remove xdg-user-dirs, since we dont need those default dirs
sudo apt-get purge -y xdg-user-dirs

# clean .vnc/passwd constantly
echo rm -f \~/.vnc/passwd | sudo tee /etc/profile.d/vnc.sh

# clean up
sudo apt-get autoremove -y --purge
