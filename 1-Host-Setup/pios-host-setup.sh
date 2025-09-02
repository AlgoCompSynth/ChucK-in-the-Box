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
sudo apt-get install -qqy --no-install-recommends \
  bluetooth \
  >> $LOGFILE 2>&1
sudo service bluetooth stop
diff main.conf /etc/bluetooth/main.conf || true
sudo cp main.conf /etc/bluetooth/main.conf
sudo service bluetooth start

if [[ "$LOW_CAPACITY_SYSTEM" == "0" ]]
then
  sudo apt-get install -qqy --no-install-recommends \
    podman \
    uidmap \
    >> $LOGFILE 2>&1

  echo "Installing Distrobox globally"
  pushd $PROJECTS > /dev/null
    rm -fr distrobox
    git clone https://github.com/89luca89/distrobox.git \
      >> $LOGFILE 2>&1
    cd distrobox
    sudo ./install \
      >> $LOGFILE 2>&1
  popd > /dev/null
  which distrobox
  distrobox --version

fi

echo "Updating locate database"
sudo updatedb \
  >> $LOGFILE 2>&1

echo "** Finished PiOS Host Setup **" | tee --append $LOGFILE
