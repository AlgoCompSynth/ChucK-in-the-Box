#! /usr/bin/env bash

set -e

echo ""
echo "** Default Dependencies **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/install-default-deps.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo "Installing ChucK build dependencies" | tee --append $LOGFILE
sudo apt-get install -qqy --no-install-recommends \
  libasound2-dev \
  libsndfile1-dev \
  >> $LOGFILE 2>&1

echo "Installing Faust ChuGin build dependencies" | tee --append $LOGFILE
sudo apt-get install -qqy --no-install-recommends \
  faust \
  "libfaust*" \
  libssl-dev \
  >> $LOGFILE 2>&1

echo "Installing FluidSynth ChuGin build dependencies" | tee --append $LOGFILE
sudo apt-get install -qqy --no-install-recommends \
  libfluidsynth-dev \
  >> $LOGFILE 2>&1

echo "** Finished Default Dependencies **" | tee --append $LOGFILE
echo ""
