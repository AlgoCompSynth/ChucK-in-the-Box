#! /usr/bin/env bash

set -e

echo ""
echo "*** ChucK and ChuGins ***"

echo "Setting ChucK version"
export CHUCK_VERSION="chuck-1.5.5.0"

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_chuck.log
rm --force $LOGFILE

mkdir --parents $HOME/Projects
echo ""
echo "Cloning repository"
pushd $HOME/Projects
  rm -fr miniAudicle
  /usr/bin/time git clone --recurse-submodules \
    https://github.com/ccrma/miniAudicle.git \
    >> $LOGFILE 2>&1
popd > /dev/null

echo ""
echo "Building ChucK"
pushd $HOME/Projects/miniAudicle/src/chuck/src
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=1 linux-alsa \
    >> $LOGFILE 2>&1
  echo "Installing ChucK"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo ""
echo "Building default ChuGins"
pushd $HOME/Projects/miniAudicle/src/chugins
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=1 linux-alsa \
    >> $LOGFILE 2>&1
  echo "Installing default ChuGins"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo ""
echo "Building Faust ChuGin"
pushd $HOME/Projects/miniAudicle/src/chugins/Faust
  /usr/bin/time make --jobs=1 linux-alsa \
    >> $LOGFILE 2>&1
  echo "Installing Faust ChuGin"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo ""
echo "Building FluidSynth ChuGin"
pushd $HOME/Projects/miniAudicle/src/chugins/FluidSynth
  /usr/bin/time make --jobs=1 linux-alsa \
    >> $LOGFILE 2>&1
  echo "Installing FluidSynth ChuGin"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Finished"
