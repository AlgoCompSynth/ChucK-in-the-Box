#! /usr/bin/env bash

set -e

echo ""
echo "** miniAudicle **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/miniaudicle.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo "Installing miniAudicle build dependencies" | tee --append $LOGFILE
sudo apt-get install -qqy --no-install-recommends \
  libcanberra-gtk3-module \
  libqscintilla2-qt6-dev \
  qt6-base-dev \
  qt6-base-dev-tools \
  qt6-wayland \
  >> $LOGFILE 2>&1

echo "Setting Qt version"
export QT_SELECT=qt6
export PATH=/usr/lib/qt6/bin:$PATH

pushd $MINIAUDICLE_PATH > /dev/null
  export CHUCK_VERSION="chuck-$(chuck --version 2>&1 | grep version | sed 's/^.*: //' | sed 's/ .*$//')"
  echo "Checking out $CHUCK_VERSION"
  git checkout "$CHUCK_VERSION" \
  >> $LOGFILE 2>&1
  echo "Building miniAudicle" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL $CHUCK_DRIVERS \
    >> $LOGFILE 2>&1
  echo "Installing miniAudicle" | tee --append $LOGFILE
  /usr/bin/time sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

# https://forums.raspberrypi.com/viewtopic.php?t=110098
echo "Adding miniAudicle to the 'Sound and Video' menu" | tee --append $LOGFILE
sudo mkdir --parents \
  /usr/local/share/applications \
  /usr/local/share/icons
sudo cp \
  $HOME/Projects/miniAudicle/installer/mac/resources/chuck_logo.png \
  /usr/local/share/icons/
sudo cp \
  ./configs/miniAudicle.desktop \
  /usr/local/share/applications/

echo "** Finished miniAudicle **" | tee --append $LOGFILE
