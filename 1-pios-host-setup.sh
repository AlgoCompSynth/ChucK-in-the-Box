#! /usr/bin/env bash

set -e

echo ""
echo "* PiOS Host Setup *"

source ./set_envars.sh
export LOGFILE=$LOGFILES/1-pios-host-setup.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

./scripts/enlarge-swap.sh

sudo cp configs/bookworm-backports.list /etc/apt/sources.list.d/
./scripts/upgrade-system.sh
./scripts/apt-packages.sh

# https://wiki.debian.org/BluetoothUser
#echo "Reconfiguring Bluetooth" | tee --append $LOGFILE
#sudo service bluetooth stop
#diff bluetooth-main.conf /etc/bluetooth/main.conf || true
#sudo cp bluetooth-main.conf /etc/bluetooth/main.conf
#sudo service bluetooth start

if [[ "$BLOKAS_PISOUND" == "1" ]]
then
  echo ""
  echo ""
  echo "Installing Blokas Pisound software"
  curl --silent https://blokas.io/pisound/install.sh | sh \
    >> $LOGFILE 2>&1

fi

./scripts/apt-terminal-setup.sh
source $HOME/.bash_aliases

echo "Installing distrobox from git repo" | tee --append $LOGFILE
mkdir --parents $HOME/Projects
pushd $HOME/Projects
  rm -fr distrobox
  git clone --quiet https://github.com/89luca89/distrobox.git
  cd distrobox
  ./install
popd

echo "Updating apt-file database"
sudo apt-file update \
  >> $LOGFILE 2>&1

echo "Updating locate database"
sudo updatedb \
  >> $LOGFILE 2>&1

echo "Reboot before proceeding!"
echo ""
echo ""
echo "* Finished PiOS Host Setup *" | tee --append $LOGFILE
