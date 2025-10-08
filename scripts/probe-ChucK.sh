#! /usr/bin/env bash

set -e

echo ""
echo "** Probe ChucK **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/probe-ChucK.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo "" | tee --append $LOGFILE
echo "chuck --probe --driver:pulse" | tee --append $LOGFILE
chuck --probe --driver:pulse 2>&1 | tee --append $LOGFILE

echo "" | tee --append $LOGFILE
echo "chuck --chugin-probe" | tee --append $LOGFILE
chuck --chugin-probe 2>&1 | tee --append $LOGFILE

echo ""
echo ""
echo "Probe results have been saved in $LOGFILE"
echo ""
echo ""

echo "** Finished Probe ChucK **" | tee --append $LOGFILE
