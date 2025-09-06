#! /usr/bin/env bash

set -e

echo ""
echo "* miniAudicle *"

source ./set_envars.sh
export LOGFILE=$LOGFILES/miniaudicle.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo "Setting Qt version"
export QT_SELECT=qt6
export PATH=/usr/lib/qt6/bin:$PATH

echo "Recursively cloning miniAudicle repository - this takes some time" | tee --append $LOGFILE
pushd $PROJECTS > /dev/null
  rm -fr miniAudicle
  /usr/bin/time git clone \
    --recurse-submodules \
    --branch $CHUCK_VERSION \
    https://github.com/ccrma/miniAudicle.git \
    >> $LOGFILE 2>&1
popd > /dev/null

pushd $CHUCK_PATH > /dev/null
  echo "Building ChucK" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux-alsa \
    >> $LOGFILE 2>&1
  echo "Installing ChucK" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null
echo "chuck --probe" | tee --append $LOGFILE
chuck --probe | tee --append $LOGFILE

pushd $CHUGINS_PATH > /dev/null
  echo "" | tee --append $LOGFILE
  echo "Building ChuGins" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux \
    >> $LOGFILE 2>&1
  echo "Installing ChuGins" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null
echo "chuck --chugin-probe" | tee --append $LOGFILE
chuck --chugin-probe | tee --append $LOGFILE

pushd $MINIAUDICLE_PATH > /dev/null
  echo "" | tee --append $LOGFILE
  echo "Building miniAudicle" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux-alsa \
    >> $LOGFILE 2>&1
  echo "Installing miniAudicle" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "* Finished miniAudicle *" | tee --append $LOGFILE
