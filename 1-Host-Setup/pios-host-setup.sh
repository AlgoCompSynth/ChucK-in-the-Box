#! /usr/bin/env bash

set -e

echo ""
echo "** PiOS Host Setup **"

source ../set_envars.sh
export LOGFILE=$LOGFILES/pios-host-setup.log
rm --force $LOGFILE

echo "Installing 'nerd fonts' for user"
mkdir --parents $HOME/.fonts
pushd $HOME/.fonts > /dev/null
  rm --force Meslo.zip
  curl -sOL \
    https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip
  unzip -qqo Meslo.zip
  rm --force Meslo.zip LICENSE.txt README.md
popd > /dev/null

./command-line-tools.sh

# https://wiki.debian.org/BluetoothUser
echo "Reconfiguring Bluetooth" | tee --append $LOGFILE
sudo service bluetooth stop
diff main.conf /etc/bluetooth/main.conf || true
sudo cp main.conf /etc/bluetooth/main.conf
sudo service bluetooth start

if [[ "$LOW_CAPACITY_SYSTEM" == "0" ]]
then
  echo "Full capacity system - installing qpwgraph"
  sudo apt-get install -qqy --no-install-recommends \
    qpwgraph \
    >> $LOGFILE 2>&1

fi

if [[ "$BLOKAS_PISOUND" == "1" ]]
then
  echo "Installing Blokas Pisound software"
  curl --silent https://blokas.io/pisound/install.sh | sh \
    >> $LOGFILE 2>&1

fi

echo "Updating apt-file database"
sudo apt-file update \
  >> $LOGFILE 2>&1

echo "Updating locate database"
sudo updatedb \
  >> $LOGFILE 2>&1

echo "** Finished PiOS Host Setup **" | tee --append $LOGFILE
