#! /usr/bin/env bash

set -e

echo ""
echo "** FluidSynth ChuGin **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/install-FluidSynth-ChuGin.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo "" | tee --append $LOGFILE
echo "Installing FluidSynth ChuGin build dependencies" | tee --append $LOGFILE
sudo apt-get install -qqy --no-install-recommends \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  fluidsynth \
  libfluidsynth-dev \
  opl3-soundfont \
  polyphone \
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
