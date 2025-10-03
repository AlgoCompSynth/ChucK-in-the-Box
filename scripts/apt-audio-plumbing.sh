#! /usr/bin/env bash

set -e

echo ""
echo "** Apt Audio Plumbing **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/apt-audio-plumbing.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -qqy \
  chuck \
  libsox-fmt-all \
  pipewire-audio \
  pipewire-doc \
  pmidi \
  sox \
  wireplumber-doc \
  >> $LOGFILE 2>&1

echo "** Finished Audio Plumbing **"
