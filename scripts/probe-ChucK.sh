#! /usr/bin/env bash

set -e

echo ""
echo "** Probe ChucK **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/probe-ChucK.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo "" | tee --append $LOGFILE
echo "chuck --probe" | tee --append $LOGFILE
chuck --probe | tee --append $LOGFILE > chuck-probe.log
echo "chuck --chugin-probe" | tee --append $LOGFILE
chuck --chugin-probe | tee --append $LOGFILE >> chuck-probe.log

echo "** Finished Probe ChucK **" | tee --append $LOGFILE
