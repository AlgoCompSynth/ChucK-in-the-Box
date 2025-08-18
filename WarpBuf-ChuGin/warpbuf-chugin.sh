#! /usr/bin/env bash

set -e

echo ""
echo "*** WarpBuf ChuGin ***"

source ../set_envars.sh
export LOGFILE=$LOGFILES/warpbuf-chugin.log
rm --force $LOGFILE

echo "Installing Linux dependencies" | tee --append $LOGFILE
/usr/bin/time sudo apt-get install --assume-yes \
  cmake \
  libmp3lame-dev \
  libspeex-dev \
  libsqlite3-dev \
  >> $LOGFILE 2>&1

pushd $HOME/Projects/chugins/WarpBuf > /dev/null
  echo "" >> $LOGFILE
  echo "Building WarpBuf ChuGin" | tee --append $LOGFILE
  git submodule update --init --recursive \
    >> $LOGFILE 2>&1
  sh build_unix.sh \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE
  echo "Installing WarpBuf ChuGin" | tee --append $LOGFILE
  cp build/WarpBuf.chug $CHUGIN_PATH/
popd > /dev/null

echo "*** Finished WarpBuf ChuGin ***" | tee --append $LOGFILE
