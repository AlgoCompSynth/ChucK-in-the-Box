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
  libsox3 \
  libsox-dev \
  libsox-fmt-all \
  libsoxr0 \
  libsoxr-dev \
  libspa-0.2-bluetooth \
  mp3splt \
  pipewire-alsa \
  pipewire-doc \
  pmidi \
  rtkit \
  sox \
  wireplumber \
  wireplumber-doc \
  >> $LOGFILE 2>&1

echo "*** Finished ***"
