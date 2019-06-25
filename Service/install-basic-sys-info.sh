#!/bin/sh

# useful veriable
SERVICE=basic-sys-info

# extends the sudo timeout for another 15 minutes
sudo -v

# install service
sudo cp ${SERVICE}/${SERVICE}.sh /bin/${SERVICE}.sh
sudo cp ${SERVICE}/${SERVICE} /etc/init.d/${SERVICE}
sudo update-rc.d ${SERVICE} defaults
sudo service ${SERVICE} restart

# install viewer of service
sudo cp ${SERVICE}/hst-status /usr/local/bin/hst-status
