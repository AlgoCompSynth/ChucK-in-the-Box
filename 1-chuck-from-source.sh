#! /usr/bin/env bash

set -eu

echo ""
echo "* ChucK from Source *"

source ./set_envars.sh
export LOGFILE=$LOGFILES/1-chuck-from-source.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo "Testing for installed PulseAudio support"
if [[ "$(dpkg-query --list | grep -i pulse | wc -l)" == "0" ]]
then
  while true; do
    read -p "Do you want to install PulseAudio (y/n)?" yn

    case $yn in
      [Yy]* )
        export CHUCK_DRIVERS="linux-alsa linux-pulse"
        echo "PulseAudio will be installed."
        break
        ;;

      [Nn]* )
        export CHUCK_DRIVERS="linux-alsa"
        echo "PulseAudio won't be installed."
        break
        ;;

      * )
        echo "Please answer yes or no."
        ;;

    esac

  done

else
  echo "PulseAudio is already installed"
  export CHUCK_DRIVERS="linux-alsa linux-pulse"

fi

echo "CHUCK_DRIVERS: $CHUCK_DRIVERS"
./scripts/upgrade-system.sh
./scripts/command-line.sh
./scripts/terminal-setup.sh
./scripts/chuck.sh
./scripts/default-chugins.sh
./scripts/faust-chugin.sh
./scripts/warpbuf-chugin.sh
./scripts/fluidsynth-chugin.sh

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
echo "* Finished ChucK from Source *" | tee --append $LOGFILE
