#! /usr/bin/env bash

set -e

echo ""
echo "* zypper Container Hosting *"

mkdir --parents $HOME/Logfiles
export LOGFILE=$HOME/Logfiles/zypper-container-hosting.log
rm --force $LOGFILE

sudo zypper install -y \
  podman \
  >> $LOGFILE 2>&1

./distrobox.sh

echo "* Finished zypper Container Hosting *"
