#! /usr/bin/env bash

set -e

echo ""
echo "*** miniAudicle ***"

export LOGFILE=$LOGFILES/6_miniaudicle.log
rm --force $LOGFILE

echo "Installing Linux dependencies"
export DEBIAN_FRONTEND=noninteractive
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
echo "Cloning miniAudicle repository - this takes some time" | tee --append $LOGFILE
pushd $HOME/Projects > /dev/null
  rm -fr miniAudicle
  /usr/bin/time git clone --recurse-submodules \
    https://github.com/ccrma/miniAudicle.git \
    >> $LOGFILE 2>&1
popd > /dev/null

pushd $HOME/Projects/miniAudicle/src > /dev/null
  echo "" >> $LOGFILE
  echo "Building miniAudicle" | tee --append $LOGFILE
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux-all \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE
  echo "Installing miniAudicle" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "" >> $LOGFILE
echo "ldconfig" | tee --append $LOGFILE
sudo /sbin/ldconfig --verbose \
  >> $LOGFILE 2>&1

echo "*** Finished miniAudicle ***"
