#!/bin/sh

VNC_INSTALLER="tigervncserver_1.8.0-1ubuntu1_amd64.deb"
VNC_LINK="https://bintray.com/tigervnc/stable/download_file?file_path=ubuntu-16.04LTS%2Famd64%2Ftigervncserver_1.8.0-1ubuntu1_amd64.deb"

# download vnc installer to /tmp
cd /tmp
curl -L "${VNC_LINK}" -o "${VNC_INSTALLER}"

# install vnc server
sudo -v
sudo dpkg -i "${VNC_INSTALLER}"
sudo apt-get install -f
curl -L https://gist.github.com/yu020009/363736a0368ee088b496fa90eac59492/raw/ | \
  sudo tee /usr/bin/vncserver
sudo chmod +x /usr/bin/vncserver 

# clean up
rm -f "${VNC_INSTALLER}"
