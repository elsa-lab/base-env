#!/usr/bin/env bash

# Cause the script to exit on any errors
# Reference: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -euo pipefail

# extends the sudo timeout for another 15 minutes
sudo -v

# packagecloud provides scripts to automate the process of configuring the package repository on the system, importing signing-keys etc.
# reference: https://github.com/git-lfs/git-lfs/blob/main/INSTALLING.md
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash

# with the packagecloud repository configured for the system, install Git LFS:
sudo apt-get install git-lfs -y