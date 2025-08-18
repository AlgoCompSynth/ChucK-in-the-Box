#! /usr/bin/env bash

set -e

echo ""
echo "*** Desktop Setup ***"

echo "Creating \$HOME/Projects, \$HOME/Logfiles, and \$HOME/.local/bin"
mkdir --parents $HOME/Projects $HOME/Logfiles $HOME/.local/bin

echo "Setting base configuration files"
cp bash_aliases $HOME/.bash_aliases; source bash_aliases
cp vimrc $HOME/.vimrc

echo "Installing Starship"
./starship.sh

echo "Installing 'nerd fonts'"
./nerd_fonts.sh

echo "Installing Cinnamon core desktop"
export LOGFILE=$HOME/Logfiles/cinnamon-core.log
sudo apt-get install --assume-yes \
  cinnamon-core \
  > $LOGFILE 2>&1

echo "Manual configuration required via 'sudo raspi-config!'"
echo ""
echo "    1. System Options > Boot > Desktop GUI"
echo "    2. System Options > Auto Login > Console No; Desktop No"
echo ""
echo "Finish with reboot"
sleep 10
sudo raspi-config

echo "*** Finished Desktop Setup ***" | tee --append $LOGFILE
