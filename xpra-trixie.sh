#! /usr/bin/env bash

set -e

echo ""
echo "** Xpra **"

mkdir --parents "$HOME/Logfiles"
export LOGFILE="$HOME/Logfiles/xpra-trixie.log"
rm --force $LOGFILE

echo "Installing Xpra repo"
sudo rm --force "/usr/share/keyrings/xpra.asc"
sudo wget -O "/usr/share/keyrings/xpra.asc" \
  https://xpra.org/xpra.asc
sudo rm --force "/etc/apt/sources.list.d/xpra.sources"
sudo wget -O "/etc/apt/sources.list.d/xpra.sources" \
  https://raw.githubusercontent.com/Xpra-org/xpra/master/packaging/repos/trixie/xpra.sources

echo "Installing Xpra"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update -qq
/usr/bin/time sudo apt-get install -qqy \
  xpra \
  >> $LOGFILE 2>&1

echo "** Finished Xpra **"
echo ""
