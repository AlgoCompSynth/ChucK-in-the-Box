#! /usr/bin/env bash

set -e

echo ""
echo "*** Container Hosting ***"

source ../set_envars.sh
echo "Creating \$HOME/Projects, $LOGFILES, and \$HOME/.local/bin"
mkdir --parents $HOME/Projects $LOGFILES $HOME/.local/bin
export LOGFILE=$LOGFILES/container-hosting.log
rm --force $LOGFILE

sudo apt-get install --assume-yes \
  podman \
  uidmap \
  >> $LOGFILE 2>&1

pushd $HOME/Projects > /dev/null
  rm -fr distrobox
  git clone https://github.com/89luca89/distrobox.git \
    >> $LOGFILE 2>&1
  cd distrobox
  sudo ./install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "*** Finished Container Hosting ***" | tee --append $LOGFILE
