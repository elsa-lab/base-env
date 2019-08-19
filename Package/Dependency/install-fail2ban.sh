#!/bin/sh

# extends the sudo timeout for another 15 minutes
sudo -v

# install fail2ban
sudo apt install fail2ban -y

# allow 140.114.xxx.xxx
echo '
[DEFAULT]

bantime  = 86400
ignoreip = 127.0.0.1/8 140.114.0.0.1/16
' | sudo tee /etc/fail2ban/jail.local

# restart fail2ban
sudo service fail2ban restart
