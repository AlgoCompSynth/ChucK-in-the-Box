#! /usr/bin/env bash

set -e

echo ""
echo "** ChuGL **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/chugl.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo "Installing Linux dependencies"
sudo apt-get install -qqy --no-install-recommends \
  libwayland-bin \
  libwayland-dev \
  libxcursor-dev \
  libxi-dev \
  libxinerama-dev \
  libxkbcommon-dev \
  libxrandr-dev \
  >> $LOGFILE 2>&1

pushd $CHUGL_PATH > /dev/null
  echo "Checking out $CHUGL_SOURCE_VERSION"
  git checkout $CHUGL_SOURCE_VERSION \
    >> $LOGFILE 2>&1
  echo "Configuring ChuGL" | tee --append $LOGFILE
  cmake -B build \
    >> $LOGFILE 2>&1
  echo "Building ChuGL" | tee --append $LOGFILE
  cd build
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL \
    >> $LOGFILE 2>&1
  echo "Installing ChuGL" | tee --append $LOGFILE
  sudo cp ChuGL.chug $CHUGINS_LIB_PATH
popd > /dev/null

echo "** Finished ChuGL **" | tee --append $LOGFILE
