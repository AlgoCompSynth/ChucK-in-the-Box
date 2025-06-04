#! /usr/bin/env bash

set -e

echo ""
echo "*** ChucK and ChuGins ***"

echo "Setting ChucK version"
export CHUCK_VERSION="chuck-1.5.5.0"

mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_chuck.log
rm --force $LOGFILE

mkdir --parents $HOME/Projects
echo "Cloning repository"
pushd $HOME/Projects > /dev/null
  rm -fr miniAudicle
  /usr/bin/time git clone --recurse-submodules \
    https://github.com/ccrma/miniAudicle.git \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Building ChucK"
pushd $HOME/Projects/miniAudicle/src/chuck/src > /dev/null
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=1 linux-alsa \
    >> $LOGFILE 2>&1
  echo "Installing ChucK"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Building default ChuGins"
pushd $HOME/Projects/miniAudicle/src/chugins > /dev/null
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=1 linux-alsa \
    >> $LOGFILE 2>&1
  echo "Installing default ChuGins"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Building Faust ChuGin"
pushd $HOME/Projects/miniAudicle/src/chugins/Faust > /dev/null
  /usr/bin/time make --jobs=1 linux-alsa \
    >> $LOGFILE 2>&1
  echo "Installing Faust ChuGin"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Finished"
