#! /usr/bin/env bash

set -e

echo ""
echo "*** Terminal Setup ***"

echo "Setting base configuration files"
cp bash_aliases $HOME/.bash_aliases; source bash_aliases
cp vimrc $HOME/.vimrc

echo "Installing Starship"
./starship.sh

echo "Installing 'nerd fonts'"
./nerd_fonts.sh

echo "*** Finished Terminal Setup ***"
