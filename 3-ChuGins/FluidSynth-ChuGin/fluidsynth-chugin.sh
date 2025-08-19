#! /usr/bin/env bash

set -e

echo ""
echo "*** FluidSynth ChuGin ***"

source ../../set_envars.sh
export LOGFILE=$LOGFILES/fluidsynth-chugin.log
rm --force $LOGFILE

echo "Installing Linux dependencies" | tee --append $LOGFILE
/usr/bin/time sudo apt-get install --assume-yes \
  libfluidsynth-dev \
  >> $LOGFILE 2>&1

pushd $HOME/Projects/chugins/FluidSynth > /dev/null
  echo "" >> $LOGFILE
  echo "Building FluidSynth ChuGin" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE
  echo "Installing FluidSynth ChuGin" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "*** Finished FluidSynth ChuGin ***" | tee --append $LOGFILE
