#! /usr/bin/env bash

set -e

echo ""
echo "*** Terminal Setup ***"

echo "Creating \$HOME/Projects, \$HOME/Logfiles, \$HOME/.local/bin, and \$HOME/bin"
mkdir --parents $HOME/Projects $HOME/Logfiles $HOME/.local/bin $HOME/bin

echo "Setting base configuration files"
cp bash_aliases $HOME/.bash_aliases; source bash_aliases
cp vimrc $HOME/.vimrc

echo "Installing Starship"
./starship.sh

echo "Installing 'nerd fonts'"
./nerd_fonts.sh

echo "*** Finished Terminal Setup ***" | tee --append $LOGFILE
