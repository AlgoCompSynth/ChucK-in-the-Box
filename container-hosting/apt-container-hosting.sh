#! /usr/bin/env bash

set -e

echo ""
echo "* Apt Container Hosting *"

mkdir --parents $HOME/Logfiles
export LOGFILE=$HOME/Logfiles/2-pios-container-hosting.log
rm --force $LOGFILE

echo ""
export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -qqy \
  podman \
  uidmap \
  >> $LOGFILE 2>&1

./distrobox.sh

echo "* Finished Apt Container Hosting *"
