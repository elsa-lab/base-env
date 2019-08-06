#!/bin/bash

# extends the sudo timeout for another 15 minutes
sudo -v

# install dependency
sudo apt install -y pandoc

# clone to /tmp
cd /tmp
git clone https://github.com/rfjakob/earlyoom.git

# build
cd earlyoom
make

# install
sudo make install

# restart earlyoom
sudo service earlyoom restart

# clean up
rm -rf /tmp/earlyoom
