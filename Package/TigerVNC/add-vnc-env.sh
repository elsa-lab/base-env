#!/bin/sh

# extends the sudo timeout for another 15 minutes
sudo -v

# clean .vnc/passwd constantly
echo rm -f \~/.vnc/passwd | sudo tee -a /etc/bash.bashrc
