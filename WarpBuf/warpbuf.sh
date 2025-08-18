#! /usr/bin/env bash

set -e

echo ""
echo "*** WarpBuf ***"

export LOGFILE=$LOGFILES/warpbuf.log
rm --force $LOGFILE

echo "Installing Linux dependencies"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install --assume-yes \
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
  sudo cp build/WarpBuf.chug /usr/local/lib/chuck/
popd > /dev/null

echo "*** Finished ChuGins ***"
