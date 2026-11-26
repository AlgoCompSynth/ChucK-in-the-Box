#! /usr/bin/env bash

set -eu

echo ""
echo "** Probe ChucK **"

export LOGFILE=$HOME/Logfiles/probe-ChucK.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo "" | tee --append $LOGFILE
if [[ "$(chuck --help 2>&1 | grep PulseAudio | wc -l)" -gt "0" ]]
then
    echo "chuck --probe --driver:pulse" | tee --append $LOGFILE
    chuck --probe --driver:pulse 2>&1 | tee --append $LOGFILE


else
    echo "chuck --probe --driver:alsa" | tee --append $LOGFILE
    chuck --probe --driver:alsa 2>&1 | tee --append $LOGFILE

fi

echo "" | tee --append $LOGFILE
echo "chuck --chugin-probe" | tee --append $LOGFILE
chuck --chugin-probe 2>&1 | tee --append $LOGFILE

echo ""
echo ""
echo "Probe results have been saved in $LOGFILE"
echo ""
echo ""

echo "** Finished Probe ChucK **" | tee --append $LOGFILE
