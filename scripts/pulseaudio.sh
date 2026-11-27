#! /usr/bin/env bash

set -eu

echo ""
echo "*** PulseAudio ***"

source ./set_envars.sh
export LOGFILE=$LOGFILES/pulseaudio.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
sudo apt-get install --no-install-recommends -qqy \
  libldacbt-abr2 \
  libldacbt-enc2 \
  libsox-fmt-pulse \
  pulseaudio \
  pulseaudio-module-bluetooth \
  pulseaudio-utils \
  >> $LOGFILE 2>&1

echo "*** Finished PulseAudio ***"

