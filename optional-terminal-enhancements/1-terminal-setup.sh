#! /usr/bin/env bash

set -e

echo ""
echo "* Terminal Setup *"

echo "Setting base configuration files"
echo "source $HOME/.bash_aliases" >> $HOME/.bashrc
cp bash_aliases $HOME/.bash_aliases; source bash_aliases
cp vimrc $HOME/.vimrc

echo "Installing Starship"
./starship.sh

echo "Installing 'nerd fonts'"
./nerd-fonts.sh

echo "Installing container hosting"
./pios-container-hosting.sh

echo "* Finished Terminal Setup *"
