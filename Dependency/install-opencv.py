#!/bin/sh

# you may also build from source:
#   http://www.python36.com/how-to-install-opencv340-on-ubuntu1604/

sudo -v
sudo apt-get update
sudo apt-get install python-opencv
sudo -H pip3 install opencv-python
