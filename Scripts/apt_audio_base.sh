#! /usr/bin/env bash

set -e

echo ""
echo "*** Audio Base Packages ***"

mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/audio_base.log"
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
sudo apt-get install --assume-yes --no-install-recommends \
  alsa-utils \
  flac \
  libsox-fmt-all \
  libsox3 \
  libsoxr0 \
  mp3splt \
  pipewire-doc \
  pmidi \
  rtkit \
  sox \
  >> $LOGFILE 2>&1

echo "Finished"
