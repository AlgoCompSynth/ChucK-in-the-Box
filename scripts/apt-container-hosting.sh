#! /usr/bin/env bash

set -e

echo ""
echo "** Container Hosting Packages **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/apt-packages.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -qqy \
  distrobox \
  podman \
  uidmap \
  >> $LOGFILE 2>&1

echo "** Finished Container Hosting Packages **"
