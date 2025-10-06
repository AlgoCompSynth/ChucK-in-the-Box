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
  alsa-utils \
  bluez-alsa-utils \
  flac \
  libpipewire-0.3-common \
  libpipewire-0.3-modules \
  libsox-fmt-all \
  libspa-0.2-bluetooth \
  libspa-0.2-libcamera \
  libspa-0.2-modules \
  mp3splt \
  pipewire \
  pipewire-doc \
  pipewire-libcamera \
  pipewire-pulse \
  pmidi \
  pulseaudio \
  pulseaudio-module-bluetooth \
  pulseaudio-utils \
  rtkit \
  sox \
  wireplumber \
  wireplumber-doc \
  >> $LOGFILE 2>&1

echo "** Finished Audio Plumbing **"
