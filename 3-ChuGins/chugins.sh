#! /usr/bin/env bash

set -e

echo ""
echo "*** ChuGins ***"

source ../set_envars.sh
export LOGFILE=$LOGFILES/chugins.log
rm --force $LOGFILE

echo "" >> $LOGFILE
echo "Cloning chugins repository" | tee --append $LOGFILE
pushd $HOME/Projects > /dev/null
  rm -fr chugins
  /usr/bin/time git clone \
    --recurse-submodules \
    --branch ${CHUCK_VERSION} \
    https://github.com/ccrma/chugins.git \
    >> $LOGFILE 2>&1
popd > /dev/null

pushd $HOME/Projects/chugins > /dev/null
  echo "" >> $LOGFILE
  echo "Building ChuGins" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE
  echo "Installing ChuGins" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "*** Finished ChuGins ***" | tee --append $LOGFILE
