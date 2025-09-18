#! /usr/bin/env bash

set -e

echo ""
echo "* PiOS Standard Setup *"

source ./set_envars.sh
export LOGFILE=$LOGFILES/1-pios-standard-setup.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

./apt-packages.sh

# https://wiki.debian.org/BluetoothUser
echo "Reconfiguring Bluetooth" | tee --append $LOGFILE
sudo service bluetooth stop
diff bluetooth-main.conf /etc/bluetooth/main.conf || true
sudo cp bluetooth-main.conf /etc/bluetooth/main.conf
sudo service bluetooth start

if [[ "$BLOKAS_PISOUND" == "1" ]]
then
  echo "Installing Blokas Pisound software"
  curl --silent https://blokas.io/pisound/install.sh | sh \
    >> $LOGFILE 2>&1

fi

./apt-terminal-setup.sh

echo "Updating apt-file database"
sudo apt-file update \
  >> $LOGFILE 2>&1

echo "Updating locate database"
sudo updatedb \
  >> $LOGFILE 2>&1

echo "Reboot before proceeding!"
echo "* Finished PiOS Standard Setup *" | tee --append $LOGFILE
