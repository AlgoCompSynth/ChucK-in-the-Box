#! /usr/bin/env bash

set -e

echo ""
echo "* miniAudicle *"

source ./set_envars.sh
export LOGFILE=$LOGFILES/3-install-miniAudicle.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

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

echo "* Finished miniAudicle *" | tee --append $LOGFILE
