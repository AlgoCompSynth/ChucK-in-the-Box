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
  alsa-topology-conf \
  alsa-ucm-conf \
  alsa-utils \
  libjack-jackd2-dev \
  libsoxr-dev \
  libsox-dev \
  libsox-fmt-all \
  pipewire \
  pipewire-doc \
  pipewire-pulse \
  pulseaudio \
  pulseaudio-utils \
  rtkit \
  sox \
  wireplumber \
  wireplumber-doc \
  >> $LOGFILE 2>&1

if [[ "$GRAPHICAL_TARGET" == "1" ]]
then
  sudo apt-get install -qqy \
    fluid-soundfont-gm \
    fluid-soundfont-gs \
    fluidsynth \
    libfluidsynth-dev \
    opl3-soundfont \
    polyphone \
    >> $LOGFILE 2>&1

fi

echo "** Finished Audio Plumbing Packages **" | tee --append $LOGFILE
