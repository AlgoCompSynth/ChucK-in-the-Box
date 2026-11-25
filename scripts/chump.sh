#! /usr/bin/env bash

set -e

echo ""
echo "** ChuMP **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/chump.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

pushd $CHUMP_PATH > /dev/null
  echo "Checking out $CHUMP_VERSION"
  git checkout "$CHUMP_VERSION" \
  >> $LOGFILE 2>&1
  echo "Building ChuMP" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux \
    >> $LOGFILE 2>&1
  echo "Installing ChuMP" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "** Finished ChuMP **" | tee --append $LOGFILE
