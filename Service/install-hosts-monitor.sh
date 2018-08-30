#!/bin/sh

# useful variable
REPO_LINK="https://github.com/BassyKuo/hosts-monitor"

# clone repo to /tmp
cd /tmp
git clone "${REPO_LINK}"

# extends the sudo timeout for another 15 minutes
sudo -v

# install service
cd hosts-monitor
sudo ./INSTALL
sudo hosts-monitor service restart 

# clean up
rm -rf /tmp/hosts-monitor
