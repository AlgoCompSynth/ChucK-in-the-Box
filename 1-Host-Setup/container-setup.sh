#! /usr/bin/env bash

set -e

echo ""
echo "** Container Setup **"

source ../set_envars.sh
echo "Creating $PROJECTS $LOGFILES $LOCALBIN"
mkdir --parents $PROJECTS $LOGFILES $LOCALBIN
export LOGFILE=$LOGFILES/container-setup.log
rm --force $LOGFILE

./command-line-audio.sh

echo "Updating locate database"
sudo updatedb \
  >> $LOGFILE 2>&1

echo "** Finished Container Setup **" | tee --append $LOGFILE
