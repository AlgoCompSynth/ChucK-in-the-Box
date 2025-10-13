#! /usr/bin/env bash

set -e

echo ""
echo "** Default ChuGins **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/default-chugins.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

pushd $CHUGINS_PATH > /dev/null
  export CHUCK_VERSION="chuck-$(chuck --version 2>&1 | grep version | sed 's/^.*: //' | sed 's/ .*$//')"
  echo "Checking out $CHUCK_VERSION"
  git checkout "$CHUCK_VERSION" \
  >> $LOGFILE 2>&1
  echo "Building default ChuGins" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux \
    >> $LOGFILE 2>&1
  echo "Installing default ChuGins" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "** Finished Default ChuGins **" | tee --append $LOGFILE
