#!/bin/sh

# extends the sudo timeout for another 15 minutes
sudo -v

# install web browser
sudo apt update
sudo apt install -y firefox fonts-moe-standard-kai

# install visual studio code
curl -L 'https://go.microsoft.com/fwlink/?LinkID=760868' -o /tmp/vs-code.deb
sudo dpkg -i /tmp/vs-code.deb

# clean up
rm -f /tmp/vs-code.deb
