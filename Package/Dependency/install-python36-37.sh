#!/usr/bin/env bash

# Cause the script to exit on any errors
# Reference: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euo pipefail

# extends the sudo timeout for another 15 minutes
sudo -v

# add Felix Krull's deadsnakes PPA
sudo add-apt-repository -y ppa:deadsnakes/ppa

# install and update 
sudo apt update
sudo apt install -y python3.6-dev python3.7-dev
sudo apt install -y python3.6-tk python3.7-tk
