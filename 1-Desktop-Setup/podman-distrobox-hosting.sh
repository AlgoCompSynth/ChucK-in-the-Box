#! /usr/bin/env bash

set -e

sudo apt-get install --assume-yes \
  flatpak \
  podman \
  uidmap \
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
    >> $LOGFILE 2>&1
