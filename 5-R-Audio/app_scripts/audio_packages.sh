#! /usr/bin/env bash

set -e

echo ""
echo "*** Audio Packages ***"

source ../../set_envars.sh
export LOGFILE=$LOGFILES/audio_packages.log
rm --force $LOGFILE

echo "Installing R audio packages as 'root' - this takes some time."
/usr/bin/time sudo ./audio_packages.R \
  >> $LOGFILE 2>&1

echo "*** Finished Audio Packages ***"
