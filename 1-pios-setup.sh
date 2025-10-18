#! /usr/bin/env bash

set -e

echo ""
echo "* PiOS Host Setup *"

source ./set_envars.sh
export LOGFILE=$LOGFILES/1-pios-setup.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

./scripts/upgrade-system.sh
./scripts/apt-command-line.sh

echo "Following script requires your attention"
./scripts/apt-jackd2.sh
./scripts/apt-audio-plumbing.sh
./scripts/clone-ccrma-repos.sh
./scripts/chuck.sh
./scripts/default-chugins.sh
./scripts/warpbuf-chugin.sh
./scripts/faust-chugin.sh

if [[ "$MAKE_PARALLEL_LEVEL" -gt "1" ]]
then
  ./scripts/fluidsynth-chugin.sh
  ./scripts/miniaudicle.sh
  ./scripts/apt-qpwgraph.sh

fi

echo ""
echo "Copying aliases to $HOME/.bash_aliases"
cp ./configs/bash_aliases $HOME/.bash_aliases

echo "Copying status query scripts to $LOCALBIN"
cp ./scripts/audio-bom.sh $LOCALBIN
cp ./scripts/list-alsa-cards.sh $LOCALBIN
cp ./scripts/probe-ChucK.sh $LOCALBIN
#cp ./scripts/pipewire-doc.sh $LOCALBIN
#cp ./scripts/wireplumber-doc.sh $LOCALBIN

echo "Updating apt-file database"
sudo apt-file update \
  >> $LOGFILE 2>&1

echo "Updating locate database"
sudo updatedb \
  >> $LOGFILE 2>&1

echo ""
echo "Reboot to reset audio daemons"
echo ""
echo "* Finished PiOS Host Setup *" | tee --append $LOGFILE
