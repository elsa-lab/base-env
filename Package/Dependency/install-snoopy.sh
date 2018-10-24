#!/bin/bash

# extends the sudo timeout for another 15 minutes
sudo -v

# download installation script to /tmp
cd /tmp
wget -O snoopy-install.sh https://github.com/a2o/snoopy/raw/install/doc/install/bin/snoopy-install.sh
chmod +x snoopy-install.sh

# install snoopy
sudo ./snoopy-install.sh stable

# clean up
rm snoopy-install.sh
