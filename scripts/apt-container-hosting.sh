#! /usr/bin/env bash

set -e

echo ""
echo "** Container Hosting Packages **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/apt-container-hosting.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -qqy \
  podman \
  >> $LOGFILE 2>&1
./scripts/distrobox.sh

echo "** Finished Container Hosting Packages **"
