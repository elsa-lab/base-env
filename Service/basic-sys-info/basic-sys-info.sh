#!/bin/bash

running=true

while ${running}; do
  nc -l 63146 <<< $(
    /usr/bin/landscape-sysinfo --sysinfo-plugins=Load,Memory,LoggedInUsers |
      sed 's/[a-zA-Z:]//g' && 
      printf " $(grep -c ^processor /proc/cpuinfo 2>/dev/null)" &&
      printf " $(date +%s)"
  )
done
