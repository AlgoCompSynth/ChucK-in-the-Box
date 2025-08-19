#! /usr/bin/env bash

set -e

echo ""
echo "*** Cinnamon Core ***"

source ../set_envars.sh
echo "Installing Cinnamon core desktop"
export LOGFILE=$LOGFILES/cinnamon-core.log
sudo apt-get install --assume-yes \
  cinnamon-core \
  firefox \
  rpi-firefox-mods \
  > $LOGFILE 2>&1

echo "Manual configuration required via 'sudo raspi-config!'"
echo ""
echo "    1. System Options > Boot > Desktop GUI"
echo "    2. System Options > Auto Login > Console No; Desktop No"
echo ""
echo "Finish with reboot"
sleep 10
sudo raspi-config

echo "*** Finished Cinnamon Core ***" | tee --append $LOGFILE
