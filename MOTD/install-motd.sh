#!/bin/sh

sudo cp 5* /etc/update-motd.d/
sudo ln -s /etc/update-motd.d/51-hdd-status /usr/local/bin/hdd-status
sudo ln -s /etc/update-motd.d/52-gpu-status /usr/local/bin/gpu-status
sudo ln -s /etc/update-motd.d/53-vnc-status /usr/local/bin/vnc-status
sudo ln -s /etc/update-motd.d/54-hst-status /usr/local/bin/hst-status
