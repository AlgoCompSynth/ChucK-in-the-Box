#! /usr/bin/env bash

set -e

echo ""
echo "*** Bluetooth Audio Packages ***"

echo "Defining LOGFILE"
mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/bluetooth_audio.log"
rm --force $LOGFILE

echo "Installing bluetooth audio packages"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install --assume-yes --no-install-recommends \
  bluetooth \
  bluez \
  bluez-alsa-utils \
  libasound2-plugin-bluez \
  >> $LOGFILE 2>&1

echo "Enabling / starting server"
sudo systemctl enable --now bluetooth

echo "Finished"
