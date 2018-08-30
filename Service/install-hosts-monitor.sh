#!/bin/sh

cd /tmp
git clone https://github.com/BassyKuo/hosts-monitor
cd hosts-monitor
sudo ./INSTALL
sudo hosts-monitor service restart 
cat /etc/ssh/sshd_banner 
