#! /usr/bin/env bash

set -e

echo "Setting environment variables"
export CHUCK_VERSION="chuck-1.5.5.0"

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_miniaudicle.log
rm --force $LOGFILE

mkdir --parents $HOME/Projects
pushd $HOME/Projects
  echo ""
  echo "Cloning repositories"
  rm -fr miniAudicle
  /usr/bin/time git clone --recurse-submodules \
    https://github.com/ccrma/miniAudicle.git \
    >> $LOGFILE 2>&1
popd

pushd $HOME/Projects/miniAudicle/src/chuck/src
  echo ""
  echo "Building ChucK"
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=1 linux-alsa \
    >> $LOGFILE 2>&1
  echo ""
  echo "Installing ChucK"
  sudo make install \
    >> $LOGFILE 2>&1
popd

pushd $HOME/Projects/miniAudicle/src/chugins
  echo ""
  echo "Building ChuGins"
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=1 linux \
    >> $LOGFILE 2>&1
  echo ""
  echo "Installing ChuGins"
  sudo make install \
    >> $LOGFILE 2>&1
popd

echo "Finished"
