#! /usr/bin/env bash

set -e

echo ""
echo "** Apt Audio Plumbing **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/apt-audio-plumbing.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -qqy --no-install-recommends \
  alsa-utils \
  libsox-fmt-all \
  pipewire \
  pipewire-doc \
  pipewire-pulse \
  pulseaudio \
  pulseaudio-module-bluetooth \
  pulseaudio-utils \
  rtkit \
  sox \
  wireplumber \
  wireplumber-doc \
  >> $LOGFILE 2>&1

echo "** Finished Audio Plumbing **"
