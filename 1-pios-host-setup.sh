#! /usr/bin/env bash

set -e

echo ""
echo "* PiOS Host Setup *"

source ./set_envars.sh
export LOGFILE=$LOGFILES/1-pios-host-setup.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

./scripts/upgrade-system.sh
./scripts/apt-command-line.sh
./scripts/apt-terminal-setup.sh
./scripts/apt-audio-plumbing.sh
source $HOME/.bash_aliases

echo "ChucK is installed - building ChuGins from source"
./scripts/clone-ccrma-repos.sh
./scripts/default-chugins.sh
./scripts/warpbuf-chugin.sh
./scripts/faust-chugin.sh
./scripts/probe-ChucK.sh

if [[ "$MAKE_PARALLEL_LEVEL" -gt "1" ]]
then
  ./scripts/fluidsynth-chugin.sh
  ./scripts/miniaudicle.sh

fi

./scripts/probe-ChucK.sh

if [[ "$BLOKAS_PISOUND" == "1" ]]
then
  echo "Installing Blokas Pisound software"
  curl --silent https://blokas.io/pisound/install.sh | sh \
    >> $LOGFILE 2>&1

fi

echo ""
echo "Updating apt-file database"
sudo apt-file update \
  >> $LOGFILE 2>&1

echo "Updating locate database"
sudo updatedb \
  >> $LOGFILE 2>&1

echo ""
echo ""
echo "Reboot before proceeding!"
echo ""
echo ""
echo "* Finished PiOS Host Setup *" | tee --append $LOGFILE
