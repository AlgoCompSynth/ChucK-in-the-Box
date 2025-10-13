#! /usr/bin/env bash

set -e

echo ""
echo "** List ALSA Cards **"

export LOGFILE=$HOME/Logfiles/list-alsa-cards.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo "" | tee --append $LOGFILE
echo "aplay --list-devices" | tee --append $LOGFILE
aplay --list-devices | tee --append $LOGFILE

echo "" | tee --append $LOGFILE
echo "aplay --list-pcms" | tee --append $LOGFILE
aplay --list-pcms | tee --append $LOGFILE

echo "" | tee --append $LOGFILE
echo "arecord --list-devices" | tee --append $LOGFILE
arecord --list-devices | tee --append $LOGFILE

echo "" | tee --append $LOGFILE
echo "arecord --list-pcms" | tee --append $LOGFILE
arecord --list-pcms | tee --append $LOGFILE

echo "" | tee --append $LOGFILE
echo "aplaymidi --list" | tee --append $LOGFILE
aplaymidi --list | tee --append $LOGFILE

echo "" | tee --append $LOGFILE
echo "arecordmidi --list" | tee --append $LOGFILE
arecordmidi --list | tee --append $LOGFILE

echo ""
echo ""
echo "Results have been saved in $LOGFILE"
echo ""
echo ""

echo "" | tee --append $LOGFILE
echo "** Finished List ALSA Cards **" | tee --append $LOGFILE
