#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
mkdir --parents $PWD/../Logs
export LOGFILE=$PWD/../Logs/install_ChucK.log
rm --force $LOGFILE

echo "Cloning repositories"
export CHUCK_VERSION="chuck-1.5.5.0"
mkdir --parents $HOME/Projects
pushd $HOME/Projects
  rm --force --recursive chuck chugins
  /usr/bin/time git clone --branch $CHUCK_VERSION \
    https://github.com/ccrma/chuck.git \
    >> $LOGFILE 2>&1
  /usr/bin/time git clone --branch $CHUCK_VERSION --recurse-submodules \
    https://github.com/ccrma/chugins.git \
    >> $LOGFILE 2>&1

  echo "Building and installing chuck"
  pushd chuck/src
    /usr/bin/time make --jobs=1 linux-alsa \
      >> $LOGFILE 2>&1
    sudo make install \
      >> $LOGFILE 2>&1
  popd

  echo "Building and installing chugins"
  pushd chugins
    /usr/bin/time make --jobs=1 linux \
      >> $LOGFILE 2>&1
    sudo make install \
      >> $LOGFILE 2>&1
  popd

popd

echo "Finished!"
