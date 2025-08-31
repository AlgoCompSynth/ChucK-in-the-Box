#! /usr/bin/env bash

set -e

echo ""
echo "** Container Setup **"

source ../set_envars.sh
echo "Creating $PROJECTS $LOGFILES $LOCALBIN"
mkdir --parents $PROJECTS $LOGFILES $LOCALBIN
export LOGFILE=$LOGFILES/container-setup.log
rm --force $LOGFILE

./apt-command-line-audio.sh

echo "** Finished Container Setup **" | tee --append $LOGFILE
