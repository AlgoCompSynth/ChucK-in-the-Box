#! /usr/bin/env bash

set -e

echo ""
echo "*** Audio Base Packages ***"

mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/audio_base.log"
rm --force $LOGFILE

echo "Installing audio base packages"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get install --assume-yes --no-install-recommends \
  alsa-utils \
  flac \
  libsox-fmt-all \
  libsox3 \
  libsoxr0 \
  libspa-0.2-bluetooth \
  mp3splt \
  pipewire-alsa \
  pmidi \
  rtkit \
  sox \
  wireplumber \
  wireplumber-doc \
  >> $LOGFILE 2>&1

echo "Finished"
