#!/bin/bash

STUDENT=$1
GROUP="student"
PASSWD="elsalab"

if [ "${STUDENT}" = "" ]; then
  exit 1
fi

sudo -v

if ! grep -q ${GROUP} /etc/group; then
  sudo groupadd ${GROUP}
fi

sudo adduser ${STUDENT} \
  --ingroup ${GROUP} \
  --gecos "First Last,RoomNumber,WorkPhone,HomePhone" \
  --disabled-password
echo "${STUDENT}:${PASSWD}" | sudo chpasswd
sudo mkdir /warehouse/${STUDENT}
sudo chown ${STUDENT}:${GROUP} /warehouse/${STUDENT}
sudo ln -s /warehouse/${STUDENT} /home/${STUDENT}/Warehouse
