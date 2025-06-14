#! /usr/bin/env bash

set -e

echo ""
echo "*** Check for Desktop ***"

mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/check_for_desktop.log"
rm --force $LOGFILE

source ram_kbytes.sh
echo "RAM_KBYTES: $RAM_KBYTES"
if [[ "$RAM_KBYTES" -gt "3000000" ]]
then
  echo "$RAM_KBYTES RAM kbytes found - installing gnome-terminal, variety and xrdp"
  export DEBIAN_FRONTEND=noninteractive
  sudo apt-get install --assume-yes --no-install-recommends \
    gnome-terminal \
    variety \
    xrdp \
    >> $LOGFILE 2>&1
  echo "Configure for xrdp:"
  echo "Advanced Options -> Wayland -> X11" 
  sleep 10
  sudo raspi-config
fi
