#! /usr/bin/env bash

set -e

echo ""
echo "*** miniAudicle ***"

source ../set_envars.sh
if [[ "$LOW_CAPACITY" == "1" ]]
then
  echo "LOW CAPACITY SYSTEM!"
  echo "Not installing miniAudicle"
  exit 0
fi

export LOGFILE=$LOGFILES/miniaudicle.log
rm --force $LOGFILE

echo "Installing Linux dependencies"
/usr/bin/time sudo apt-get install --assume-yes \
  libcanberra-gtk3-module \
  libqscintilla2-qt6-dev \
  qt6-base-dev \
  qt6-base-dev-tools \
  qt6-wayland \
  >> $LOGFILE 2>&1

echo "Setting Qt version"
export QT_SELECT=qt6
export PATH=/usr/lib/qt6/bin:$PATH

echo "" >> $LOGFILE
echo "Recursively cloning miniAudicle repository - this takes some time" | tee --append $LOGFILE
pushd $PROJECTS > /dev/null
  rm -fr miniAudicle
  /usr/bin/time git clone --recurse-submodules \
    --branch $CHUCK_VERSION \
    https://github.com/ccrma/miniAudicle.git \
    >> $LOGFILE 2>&1
popd > /dev/null

pushd $PROJECTS/miniAudicle/src > /dev/null
  echo "" >> $LOGFILE
  echo "Building miniAudicle" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux-alsa \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE
  echo "Installing miniAudicle" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Starting miniAudicle" | tee --append $LOGFILE
miniAudicle || true

echo "*** Finished miniAudicle ***" | tee --append $LOGFILE
