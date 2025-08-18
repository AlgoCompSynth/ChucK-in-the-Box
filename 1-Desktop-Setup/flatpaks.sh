#! /usr/bin/env bash

set -e

echo ""
echo "*** Flatpaks ***"

source ../set_envars.sh
export LOGFILE="$HOME/Logfiles/flatpaks.log"
rm --force $LOGFILE

echo "Installing flatpak"
sudo apt-get install --assume-yes \
  flatpak \
  >> $LOGFILE 2>&1

echo "Adding Flathub remote"
flatpak remote-add --if-not-exists \
  flathub https://dl.flathub.org/repo/flathub.flatpakrepo \
  >> $LOGFILE 2>&1

echo "Installing Firefox"
flatpak install org.mozilla.firefox

echo "*** Finished Flatpaks ***"
