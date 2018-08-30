#!/bin/sh

SERVICE=basic-sys-info

sudo cp ${SERVICE}/${SERVICE}.sh /bin/${SERVICE}.sh
sudo cp ${SERVICE}/${SERVICE} /etc/init.d/${SERVICE}
sudo update-rc.d ${SERVICE} defaults
sudo service ${SERVICE} restart
