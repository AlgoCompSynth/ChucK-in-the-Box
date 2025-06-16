#! /usr/bin/env bash

set -e

echo ""
echo "*** Xpra ***"

mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/install_xpra.log"
rm --force $LOGFILE

echo "Adding Xpra repository"
mkdir --parents $HOME/Projects
pushd $HOME/Projects > /dev/null
  rm --force --recursive xpra
  /usr/bin/time git clone https://github.com/Xpra-org/xpra \
    >> $LOGFILE 2>&1
  cd xpra
  /usr/bin/time ./setup.py install-repo \
    >> $LOGFILE 2>&1
  /usr/bin/time sudo apt-get update \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Installing xpra"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install --assume-yes \
  xpra \
  >> $LOGFILE 2>&1

echo "Finished"
