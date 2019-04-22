#!/bin/bash

ADMIN=$1
GROUP="elsa-admin"
PASSWD=$(date | md5sum | awk '{print $1}')

if [ "${ADMIN}" = "" ]; then
  echo "Usage: $0 <admin id>"
  exit 1
fi

sudo -v

if ! grep -q ${GROUP} /etc/group; then
  sudo groupmod --new-name ${GROUP} $(id -gn ${USER})
fi

sudo adduser ${ADMIN} \
  --ingroup ${GROUP} \
  --gecos "First Last,RoomNumber,WorkPhone,HomePhone" \
  --disabled-password
sudo usermod -aG sudo ${ADMIN}
echo "${ADMIN}:${PASSWD}" | sudo chpasswd
echo "Username: ${ADMIN}"
echo "  Passwd: ${PASSWD}"
