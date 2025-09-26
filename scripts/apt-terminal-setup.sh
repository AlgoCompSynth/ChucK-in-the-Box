#! /usr/bin/env bash

set -e

echo ""
echo "** Apt Terminal Setup **"

echo "Setting base configuration files"
echo "source $HOME/.bash_aliases" >> $HOME/.bashrc
cp configs/bash_aliases $HOME/.bash_aliases; source configs/bash_aliases
cp configs/vimrc $HOME/.vimrc

echo "Installing Starship"
./scripts/starship.sh

echo "Installing 'nerd fonts'"
./scripts/nerd-fonts.sh

echo "** Finished Apt Terminal Setup **"
