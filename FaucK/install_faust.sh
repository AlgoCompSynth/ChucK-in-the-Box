#! /usr/bin/env bash

set -e

echo ""
echo "*** Faust ***"

echo "Setting Faust version"
export FAUST_VERSION="2.79.3"
export FAUST_URL="https://github.com/grame-cncm/faust.git"
export FAUST_PATH="$HOME/Projects/faust"

mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_faust.log
rm --force $LOGFILE

# https://github.com/grame-cncm/faust/wiki/Building
mkdir --parents $FAUST_PATH
rm --force --recursive $FAUST_PATH
echo "Cloning Faust repository"
pushd $HOME/Projects > /dev/null
  /usr/bin/time git clone --recursive ${FAUST_URL} \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Building Faust"
pushd $FAUST_PATH > /dev/null
  git checkout ${FAUST_VERSION} \
    >> $LOGFILE 2>&1
  export CMAKE_BUILD_PARALLEL_LEVEL=`nproc`
  /usr/bin/time make all \
    >> $LOGFILE 2>&1
  echo "Installing Faust"
  export CMAKE_INSTALL_PARALLEL_LEVEL=`nproc`
  /usr/bin/time sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Finished"
