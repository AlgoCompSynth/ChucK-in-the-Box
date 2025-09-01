#! /usr/bin/env bash

set -e

echo ""
echo "** PiOS Host Setup **"

source ../set_envars.sh
echo "Creating $PROJECTS $LOGFILES $LOCALBIN"
mkdir --parents $PROJECTS $LOGFILES $LOCALBIN
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

./command-line-audio.sh

echo "Installing Linux packages" | tee --append $LOGFILE
sudo apt-get install -qqy --no-install-recommends \
  bluetooth \
  pipewire-doc \
  wireplumber-doc \
  >> $LOGFILE 2>&1

echo "Reconfiguring Bluetooth"
# https://wiki.debian.org/BluetoothUser
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

fi

echo "Updating locate database"
sudo updatedb \
  >> $LOGFILE 2>&1

echo "** Finished PiOS Host Setup **" | tee --append $LOGFILE
