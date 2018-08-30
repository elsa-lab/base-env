#!/bin/sh

sudo -v
sudo apt-get update
sudo apt-get install -y xfce4 xfce4-goodies
sudo apt-get remove xscreensaver
sudo apt autoremove
