#! /usr/bin/env bash

set -e

echo ""
echo "* pacman Container Hosting *"

mkdir --parents $HOME/Logfiles
export LOGFILE=$HOME/Logfiles/pacman-container-hosting.log
rm --force $LOGFILE

sudo pacman --sync --refresh --sysupgrade --noconfirm \
  podman \
  >> $LOGFILE 2>&1

./distrobox.sh

echo "* Finished pacman Container Hosting *"
