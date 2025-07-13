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
echo "Enable backports"
echo "deb http://deb.debian.org/debian bookworm-backports main contrib non-free" \
  | sudo tee /etc/apt/sources.list.d/bookworm-backports.list
echo "Update"
sudo apt-get update \
  >> $LOGFILE 2>&1
echo "Full upgrade"
sudo apt-get full-upgrade --assume-yes \
  >> $LOGFILE 2>&1

echo "*** Finished System Upgrade ***"
