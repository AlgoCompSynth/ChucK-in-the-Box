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
  alsa-topology-conf \
  alsa-ucm-conf \
  alsa-utils \
  bluez-firmware \
  gstreamer1.0-alsa \
  libasound2-data \
  libasound2-plugins \
  libasound2t64 \
  libatopology2t64 \
  libbluetooth3 \
  libfluidsynth3 \
  libldacbt-abr2 \
  libldacbt-enc2 \
  libopus0 \
  libpipewire-0.3-0t64 \
  libpipewire-0.3-modules \
  libpulse0 \
  libsbc1 \
  libspa-0.2-bluetooth \
  libspa-0.2-libcamera \
  libspa-0.2-modules \
  libspeex1 \
  libwireplumber-0.5-0 \
  pamixer \
  pipewire \
  pipewire-bin \
  pipewire-doc \
  pipewire-libcamera \
  pipewire-pulse \
  pulseaudio \
  pulseaudio-module-bluetooth \
  pulseaudio-utils \
  wireplumber \
  wireplumber-doc \
  >> $LOGFILE 2>&1

echo "** Finished Audio Plumbing **"
