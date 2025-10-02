#! /usr/bin/env bash

set -e

echo ""
echo "* PiOS Host Setup *"

source ./set_envars.sh
export LOGFILE=$LOGFILES/1-pios-host-setup.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

./scripts/upgrade-system.sh
./scripts/apt-packages.sh
./scripts/apt-terminal-setup.sh
source $HOME/.bash_aliases

echo ""
echo "Installing distrobox from git repo" | tee --append $LOGFILE
mkdir --parents $HOME/Projects
pushd $HOME/Projects
  sudo rm -fr distrobox
  git clone --quiet https://github.com/89luca89/distrobox.git
  cd distrobox
  sudo ./install
popd

echo ""
# https://wiki.debian.org/BluetoothUser
echo "Reconfiguring Bluetooth" | tee --append $LOGFILE
sudo service bluetooth stop
diff configs/bluetooth-main.conf /etc/bluetooth/main.conf || true
sudo cp configs/bluetooth-main.conf /etc/bluetooth/main.conf
sudo service bluetooth start

if [[ "$MAKE_PARALLEL_LEVEL" -gt "1" ]]
then
  ./scripts/apt-fluidsynth.sh

else
  echo "Shutting down desktop on next boot to save RAM"
  sudo systemctl set-default multi-user.target

fi

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
