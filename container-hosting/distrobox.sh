#! /usr/bin/env bash

set -e

echo ""
echo "** Distrobox **"

mkdir --parents $HOME/Projects

pushd $HOME/Projects > /dev/null
  rm -fr distrobox
  git clone https://github.com/89luca89/distrobox.git \
    >> $LOGFILE 2>&1
  cd distrobox
  sudo ./install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "** Finished Distrobox **"
