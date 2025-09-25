#! /usr/bin/env bash

set -e

echo ""
echo "* PiOS Setup *"

source ./set_envars.sh
export LOGFILE=$LOGFILES/1-pios-setup.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

./enlarge-swap.sh

sudo cp bookworm-backports.list /etc/apt/sources.list.d/
./apt-packages.sh

# https://wiki.debian.org/BluetoothUser
echo "Reconfiguring Bluetooth" | tee --append $LOGFILE
sudo service bluetooth stop
diff bluetooth-main.conf /etc/bluetooth/main.conf || true
sudo cp bluetooth-main.conf /etc/bluetooth/main.conf
sudo service bluetooth start

if [[ "$BLOKAS_PISOUND" == "1" ]]
then
  echo ""
  echo ""
  echo "Installing Blokas Pisound software"
  curl --silent https://blokas.io/pisound/install.sh | sh \
    >> $LOGFILE 2>&1

fi

./apt-terminal-setup.sh
source $HOME/.bash_aliases

echo ""
echo ""
echo "Installing distrobox from git repo" | tee --append $LOGFILE
mkdir --parents $HOME/Projects
pushd $HOME/Projects
  rm -fr distrobox
  git clone --quiet https://github.com/89luca89/distrobox.git
  cd distrobox
  ./install
popd

echo ""
echo ""
echo "Creating debian-trixie distrobox -"
echo "This will take some time to download"
echo "and install packages."
echo ""
echo ""
/usr/bin/time distrobox assemble create

echo ""
echo ""
echo "Setting up debian-trixie command line"
/usr/bin/time distrobox enter debian-trixie -- ./apt-terminal-setup.sh \
  >> $LOGFILE 2>&1
cp --recursive $HOME/.ssh $HOME/dbx-homes/debian-trixie/

echo ""
echo ""
echo "Installing ChucK and ChuGins in debian-trixie -"
echo "This will take some time."
/usr/bin/time distrobox enter debian-trixie -- ./install-ChucK-ChuGins.sh

if [[ "$GRAPHICAL_TARGET" == "1" ]]
then
  echo ""
  echo ""
  /usr/bin/time distrobox enter debian-trixie -- ./install-FluidSynth-ChuGin.sh

fi

echo ""
echo ""
distrobox enter debian-trixie -- ./probe-ChucK.sh

if [[ "$GRAPHICAL_TARGET" == "1" ]]
then
  echo ""
  echo ""
  echo "Installing miniAudicle in debian-trixie -"
  echo "This will take some time."
  echo ""
  echo ""
  /usr/bin/time distrobox enter debian-trixie -- ./install-miniAudicle.sh \
    >> $LOGFILE 2>&1

fi

echo ""
echo ""
echo "Updating apt-file database"
sudo apt-file update \
  >> $LOGFILE 2>&1

echo "Updating locate database"
sudo updatedb \
  >> $LOGFILE 2>&1

echo "Reboot before proceeding!"
echo ""
echo ""
echo "* Finished PiOS Setup *" | tee --append $LOGFILE
