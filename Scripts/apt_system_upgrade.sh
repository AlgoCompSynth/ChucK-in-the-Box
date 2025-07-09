#! /usr/bin/env bash

set -e

echo ""
echo "*** System Upgrade ***"

mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/system_upgrade.log"
rm --force $LOGFILE

sudo cp locale.gen /etc/
sudo locale-gen

export DEBIAN_FRONTEND=noninteractive
echo "Update"
sudo apt-get update \
  >> $LOGFILE 2>&1
echo "Full upgrade"
sudo apt-get full-upgrade --assume-yes \
  >> $LOGFILE 2>&1
echo "Autoremove"
sudo apt-get autoremove --assume-yes \
  >> $LOGFILE 2>&1

echo "*** Finished ***"
