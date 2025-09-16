#! /usr/bin/env bash

set -e

echo ""
echo "** Apt Terminal Setup **"

echo "Setting base configuration files"
echo "source $HOME/.bash_aliases" >> $HOME/.bashrc
cp bash_aliases $HOME/.bash_aliases; source bash_aliases
cp vimrc $HOME/.vimrc

echo "Installing Starship"
./starship.sh

echo "Installing 'nerd fonts'"
./nerd-fonts.sh

echo "Installing distrobox from git repo" | tee --append $LOGFILE
mkdir --parents $HOME/Projects
pushd $HOME/Projects
  rm -fr distrobox
  git clone --quiet https://github.com/89luca89/distrobox.git
  cd distrobox
  ./install
popd

echo "** Finished Apt Terminal Setup **"
echo ""
