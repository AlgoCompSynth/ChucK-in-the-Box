#! /usr/bin/env bash

set -e

echo ""
echo "** Default ChuGins **"

source ./set_envars.sh
echo "Using ***installed*** ChucK version!"
export CHUCK_VERSION=$(chuck --version 2>&1 | grep version | sed "s/^.*: //" | sed "s/ .*$//")
export LOGFILE=$LOGFILES/default-chugins.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo "Installing build dependencies" | tee --append $LOGFILE
sudo apt-get install -qqy --no-install-recommends \
  bison \
  build-essential \
  cmake \
  flex \
  libasound2-dev \
  libsndfile1-dev \
  pkgconf \
  >> $LOGFILE 2>&1

pushd $MINIAUDICLE_PATH/.. > /dev/null
  echo "Checking out source"
  git checkout "chuck-$CHUCK_VERSION" \
  >> $LOGFILE 2>&1
popd > /dev/null

pushd $CHUGINS_PATH > /dev/null
  echo "Building default ChuGins" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux \
    >> $LOGFILE 2>&1
  echo "Installing default ChuGins" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "** Finished Default ChuGins **" | tee --append $LOGFILE
