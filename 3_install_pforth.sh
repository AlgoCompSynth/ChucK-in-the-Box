#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
mkdir --parents $PWD/../Logs
export LOGFILE=$PWD/../Logs/install_pforth.log
rm --force $LOGFILE

echo "Cloning repositories"
export PFORTH_VERSION="master"
mkdir --parents $HOME/Projects
pushd $HOME/Projects
  rm --force --recursive pforth
  /usr/bin/time git clone --branch $PFORTH_VERSION \
    https://github.com/philburk/pforth.git \
    >> $LOGFILE 2>&1

  echo "Building and installing pforth"
  pushd pforth/platforms/unix
    /usr/bin/time make --jobs=1 all \
      >> $LOGFILE 2>&1
    make test
    sudo mkdir --parents /usr/local/bin
    sudo cp pforth_standalone /usr/local/bin
    sudo ln -sf /usr/local/bin/pforth_standalone /usr/local/bin/pforth
  popd

popd

echo "Finished!"
