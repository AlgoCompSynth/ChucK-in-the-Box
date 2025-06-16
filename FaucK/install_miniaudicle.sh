#! /usr/bin/env bash

set -e

echo ""
echo "*** miniAudicle ***"

echo "Setting ChucK version"
export CHUCK_VERSION="chuck-1.5.5.0"
echo "Setting Qt version"
export QT_SELECT=qt6
export PATH=/usr/lib/qt6/bin:$PATH

mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_miniaudicle.log
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
  /usr/bin/time make --jobs=`nproc` linux-pulse \
    >> $LOGFILE 2>&1
  echo "Installing ChucK"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Building ChuGins"
pushd $HOME/Projects/miniAudicle/src/chugins > /dev/null
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=`nproc` linux \
    >> $LOGFILE 2>&1
  echo "Installing ChuGins"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Building Faust ChuGin"
pushd $HOME/Projects/miniAudicle/src/chugins/Faust > /dev/null
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=`nproc` linux \
    >> $LOGFILE 2>&1
  echo "Installing Faust ChuGin"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Building FluidSynth ChuGin"
pushd $HOME/Projects/miniAudicle/src/chugins/FluidSynth > /dev/null
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=`nproc` linux \
    >> $LOGFILE 2>&1
  echo "Installing FluidSynth ChuGin"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Building miniAudicle"
pushd $HOME/Projects/miniAudicle/src > /dev/null
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=`nproc` linux-pulse \
    >> $LOGFILE 2>&1
  echo "Installing miniAudicle"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Finished"
