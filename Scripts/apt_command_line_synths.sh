#! /usr/bin/env bash

set -e

echo ""
echo "*** Command Line Synths ***"

mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/command_line_synths.log"
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install --assume-yes --no-install-recommends \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  fluidsynth \
  freepats \
  timidity \
  timidity-daemon \
  >> $LOGFILE 2>&1

echo "Finished"
