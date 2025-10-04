#! /usr/bin/env bash

set -e

echo ""
echo "Installing distrobox from git repo" | tee --append $LOGFILE
mkdir --parents $HOME/Projects
pushd $HOME/Projects
  sudo rm -fr distrobox
  git clone --quiet https://github.com/89luca89/distrobox.git
  cd distrobox
  sudo ./install
popd
