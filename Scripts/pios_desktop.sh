#! /usr/bin/env bash

set -e

echo ""
echo "*** Desktop ***"

mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/desktop.log"
rm --force $LOGFILE

echo "Installing desktop packages"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get install --assume-yes --no-install-recommends \
  task-lxqt-desktop \
  variety \
  wireplumber \
  wireplumber-doc \
  xrdp \
  >> $LOGFILE 2>&1

echo "Enabling/starting wireplumber service"
# https://wiki.debian.org/PipeWire
systemctl --user --now enable wireplumber.service
echo "Finished"
