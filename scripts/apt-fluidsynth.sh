#! /usr/bin/env bash

set -e

echo ""
echo "** Apt FluidSynth **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/apt-fluidsynth.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -qqy --no-install-recommends \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  fluidsynth \
  libfluidsynth-dev \
  opl3-soundfont \
  >> $LOGFILE 2>&1

echo "** Finished FluidSynth **"
