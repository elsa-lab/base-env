#!/bin/bash

STUDENT=$1
GROUP="student"
PASSWD="elsalab"

if [ "${STUDENT}" = "" ]; then
  echo "Usage: $0 <student id>"
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
sudo mkdir /home/${STUDENT}/Warehouse
sudo chown ${STUDENT}:${GROUP} /warehouse/${STUDENT}
sudo mount --bind /warehouse/${STUDENT} /home/${STUDENT}/Warehouse
echo /home/${STUDENT}/Warehouse /warehouse/${STUDENT} none bind 0 0 | sudo tee -a /etc/fstab
