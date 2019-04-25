#!/bin/bash

# extends the sudo timeout for another 15 minutes
sudo -v

# add J Fernyhough's PPA
sudo add-apt-repository -y ppa:jonathonf/python-3.6

# install and update 
sudo apt update && sudo apt install -y python3.6-dev
