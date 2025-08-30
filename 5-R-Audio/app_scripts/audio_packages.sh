#! /usr/bin/env bash

set -e

echo ""
echo "*** Audio Packages ***"

source ../../set_envars.sh
export LOGFILE=$LOGFILES/audio_packages.log
rm --force $LOGFILE

#echo "Installing Linux dependencies" | tee --append $LOGFILE
#/usr/bin/time sudo apt-get install --assume-yes \
  #libfftw3-dev \
  #>> $LOGFILE 2>&1

echo "Installing R audio packages as 'root' - this takes some time."
/usr/bin/time sudo ./audio_packages.R \
  >> $LOGFILE 2>&1

echo "*** Finished Audio Packages ***"
