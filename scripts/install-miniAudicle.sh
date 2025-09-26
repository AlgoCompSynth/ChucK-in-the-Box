#! /usr/bin/env bash

set -e

echo ""
echo "** miniAudicle **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/install-miniAudicle.log
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
  echo "" | tee --append $LOGFILE
  echo "Building miniAudicle" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL $CHUCK_DRIVERS \
    >> $LOGFILE 2>&1
  echo "Installing miniAudicle" | tee --append $LOGFILE
  /usr/bin/time sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Exporting miniAudicle to host"
distrobox-export --bin "$(which miniAudicle)"

echo "** Finished miniAudicle **" | tee --append $LOGFILE
