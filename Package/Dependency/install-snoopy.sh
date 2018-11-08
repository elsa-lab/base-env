#!/bin/bash

# download installation script to /tmp
cd /tmp
curl -LO https://github.com/a2o/snoopy/raw/install/doc/install/bin/snoopy-install.sh
chmod +x snoopy-install.sh

# extends the sudo timeout for another 15 minutes
sudo -v

# install snoopy
sudo ./snoopy-install.sh stable

# clean up
rm snoopy-install.sh
