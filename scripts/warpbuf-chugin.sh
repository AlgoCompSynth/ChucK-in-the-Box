#! /usr/bin/env bash

set -e

echo ""
echo "** WarpBuf ChuGin **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/warpbuf-chugin.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

pushd $CHUGINS_PATH/WarpBuf > /dev/null
  echo "Configuring WarpBuf ChuGin" | tee --append $LOGFILE
  rm --force --recursive build; mkdir --parents build; cd build
  /usr/bin/time cmake .. \
    >> $LOGFILE 2>&1
  echo "Building WarpBuf ChuGin" | tee --append $LOGFILE
  /usr/bin/time make \
    >> $LOGFILE 2>&1
  echo "Installing WarpBuf ChuGin" | tee --append $LOGFILE
  sudo cp WarpBuf.chug $CHUGINS_LIB_PATH/
    >> $LOGFILE 2>&1
popd > /dev/null

echo "** Finished WarpBuf ChuGin **" | tee --append $LOGFILE
