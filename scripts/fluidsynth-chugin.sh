#! /usr/bin/env bash

set -e

echo ""
echo "** FluidSynth ChuGin **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/fluidsynth-chugin.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo "Installing Linux dependencies"
sudo apt-get install -qqy --no-install-recommends \
  libfluidsynth-dev \
  >> $LOGFILE 2>&1

pushd $CHUGINS_PATH/FluidSynth > /dev/null
  echo "Building FluidSynth ChuGin" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux \
    >> $LOGFILE 2>&1
  echo "Installing FluidSynth ChuGin" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "** Finished FluidSynth ChuGin **" | tee --append $LOGFILE
