#! /usr/bin/env bash

set -e

echo ""
echo "*** miniAudicle ***"

echo "Setting ChucK version"
export CHUCK_VERSION="chuck-1.5.5.1"
echo "Setting Qt version"
export QT_SELECT=qt6
export PATH=/usr/lib/qt6/bin:$PATH

mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_chuck.log
rm --force $LOGFILE

mkdir --parents $HOME/Projects
echo "Cloning miniAudicle repository"
pushd $HOME/Projects > /dev/null
  rm -fr miniAudicle
  /usr/bin/time git clone --recurse-submodules \
    https://github.com/ccrma/miniAudicle.git \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Cloning ChuGL repository"
pushd $HOME/Projects > /dev/null
  rm -fr chugl
  /usr/bin/time git clone \
    https://github.com/ccrma/chugl.git \
    >> $LOGFILE 2>&1
popd > /dev/null

pushd $HOME/Projects/miniAudicle/src/chuck/src > /dev/null
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  echo "Building ChucK"
  /usr/bin/time make --jobs=1 linux-alsa \
    >> $LOGFILE 2>&1
  echo "Installing ChucK"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

pushd $HOME/Projects/miniAudicle/src/chugins > /dev/null
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  echo "Building default ChuGins"
  /usr/bin/time make --jobs=1 linux \
    >> $LOGFILE 2>&1
  echo "Installing default ChuGins"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

pushd $HOME/Projects/miniAudicle/src/chugins/Faust > /dev/null
  echo "Building Faust ChuGin"
  /usr/bin/time make --jobs=1 linux \
    >> $LOGFILE 2>&1
  echo "Installing Faust ChuGin"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

pushd $HOME/Projects/miniAudicle/src/chugins/FluidSynth > /dev/null
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  echo "Building FluidSynth ChuGin"
  /usr/bin/time make --jobs=1 linux \
    >> $LOGFILE 2>&1
  echo "Installing FluidSynth ChuGin"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

pushd $HOME/Projects/chugl/src > /dev/null
  echo "Building ChuGL"
  /usr/bin/time make linux \
    >> $LOGFILE 2>&1
  echo "Installing ChuGL"
  sudo cp ChuGL.chug /usr/local/lib/chuck/
popd > /dev/null

pushd $HOME/Projects/miniAudicle/src > /dev/null
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  echo "Building miniAudicle"
  /usr/bin/time make --jobs=1 linux-alsa \
    >> $LOGFILE 2>&1
  echo "Installing miniAudicle"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "*** Finished miniAudicle ***"
