#! /usr/bin/env bash

set -e

echo ""
echo "* dnf Container Hosting *"

mkdir --parents $HOME/Logfiles
export LOGFILE=$HOME/Logfiles/dnf-container-hosting.log
rm --force $LOGFILE

sudo dnf install -y \
  podman \
  >> $LOGFILE 2>&1

./distrobox.sh

echo "* Finished dnf Container Hosting *"
