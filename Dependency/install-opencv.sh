#!/bin/sh

# you may also try to build from source:
#   http://www.python36.com/how-to-install-opencv340-on-ubuntu1604/

# extends the sudo timeout for another 15 minutes
sudo -v

# install opencv
sudo apt-get update
sudo apt-get install -y python-opencv

# install package python-opencv additionally if using python3
sudo -H pip3 install opencv-python
