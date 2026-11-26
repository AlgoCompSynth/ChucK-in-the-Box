#! /usr/bin/env bash

set -e

echo ""
echo "* PiOS Host Setup *"

source ./set_envars.sh
export LOGFILE=$LOGFILES/1-pios-setup.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

./scripts/upgrade-system.sh
./scripts/command-line.sh
./scripts/terminal-setup.sh
./scripts/clone-ccrma-repos.sh
./scripts/chuck.sh
./scripts/default-chugins.sh
./scripts/faust-chugin.sh
./scripts/warpbuf-chugin.sh
./scripts/fluidsynth-chugin.sh
./scripts/chump.sh
./scripts/chugl.sh

echo ""
echo "Copying status query scripts to $LOCALBIN"
cp ./scripts/list-alsa-cards.sh $LOCALBIN
cp ./scripts/probe-ChucK.sh $LOCALBIN


echo "Updating apt-file database"
sudo apt-file update \
  >> $LOGFILE 2>&1

echo "Updating locate database"
sudo updatedb \
  >> $LOGFILE 2>&1

echo ""
echo "* Finished PiOS Host Setup *" | tee --append $LOGFILE
