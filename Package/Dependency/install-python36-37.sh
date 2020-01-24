#!/bin/bash

# extends the sudo timeout for another 15 minutes
sudo -v

# add Felix Krull's deadsnakes PPA
sudo add-apt-repository -y ppa:deadsnakes/ppa

# install and update 
sudo apt update
sudo apt install -y python3.6-dev python3.7-dev
sudo apt install -y python3.6-tk python3.7-tk

