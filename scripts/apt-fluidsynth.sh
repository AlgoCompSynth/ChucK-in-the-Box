#! /usr/bin/env bash

set -e

echo ""
echo "** FluidSynth Packages **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/apt-fluidsynth.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

sudo apt-get install -qqy --no-install-recommends \
  flac \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  fluidsynth \
  libsox-fmt-all \
  mp3splt \
  pmidi \
  sox \
  >> $LOGFILE 2>&1

echo "** Finished FluidSynth Packages **" | tee --append $LOGFILE
