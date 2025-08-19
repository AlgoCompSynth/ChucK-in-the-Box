#! /usr/bin/env bash

set -e

echo ""
echo "*** Desktop Setup ***"

source ../set_envars.sh
echo "Creating \$HOME/Projects, $LOGFILES, and \$HOME/.local/bin"
mkdir --parents $HOME/Projects $LOGFILES $HOME/.local/bin
export LOGFILE=$LOGFILES/desktop-setup.log
rm --force $LOGFILE

echo "Setting base configuration files"
cp bash_aliases $HOME/.bash_aliases; source bash_aliases
cp vimrc $HOME/.vimrc

echo "Installing utilities" | tee --append $LOGFILE
sudo apt-get install --assume-yes \
  apt-file \
  git \
  plocate \
  qpwgraph \
  tilix \
  time \
  tree \
  vim \
  >> $LOGFILE 2>&1

echo "Installing Starship"
./starship.sh

echo "Installing 'nerd fonts'"
./nerd_fonts.sh

echo "Installing container hosting"
./podman-distrobox-hosting.sh

echo "*** Finished Desktop Setup ***" | tee --append $LOGFILE
