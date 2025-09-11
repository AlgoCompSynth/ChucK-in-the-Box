#! /usr/bin/env bash

set -e

echo ""
echo "* PiOS Container Hosting *"

source ./set_envars.sh
export LOGFILE=$LOGFILES/pios-container-hosting.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo "Installing host tools"
sudo apt-get install -qqy --no-install-recommends \
  bluetooth \
  podman \
  uidmap \
  >> $LOGFILE 2>&1

# https://wiki.debian.org/BluetoothUser
echo "Reconfiguring Bluetooth" | tee --append $LOGFILE
sudo service bluetooth stop
diff bluetooth-main.conf /etc/bluetooth/main.conf || true
sudo cp bluetooth-main.conf /etc/bluetooth/main.conf
sudo service bluetooth start

echo "Installing distrobox from git repo" | tee --append $LOGFILE
pushd $HOME/Projects
  rm -fr distrobox
  git clone https://github.com/89luca89/distrobox.git \
    >> $LOGFILE 2>&1
  cd distrobox
  ./install \
    >> $LOGFILE 2>&1
popd

echo "* Finished PiOS Container Hosting *" | tee --append $LOGFILE
