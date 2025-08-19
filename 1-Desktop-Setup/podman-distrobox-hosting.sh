#! /usr/bin/env bash

set -e

source ../set_envars.sh

sudo apt-get install --assume-yes \
  flatpak \
  podman \
  uidmap \
  tilix \
  >> $LOGFILE 2>&1

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

mkdir --parents $HOME/Projects
pushd $HOME/Projects > /dev/null
  rm -fr distrobox
  git clone https://github.com/89luca89/distrobox.git \
    >> $LOGFILE 2>&1
  cd distrobox
  sudo ./install \
    >> $LOGFILE 2>&1
popd > /dev/null

flatpak install --assumeyes \
  io.github.dvlv.boxbuddyrs \
  org.rncbc.qpwgraph \
  org.mozilla.firefox \
    >> $LOGFILE 2>&1
