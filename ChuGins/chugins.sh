#! /usr/bin/env bash

set -e

echo ""
echo "*** ChuGins ***"

export LOGFILE=$LOGFILES/chugins.log
rm --force $LOGFILE

echo "Installing Linux dependencies"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install --assume-yes \
  >> $LOGFILE 2>&1

echo "" >> $LOGFILE
echo "Cloning chugins repository" | tee --append $LOGFILE
pushd $HOME/Projects > /dev/null
  rm -fr chugins
  /usr/bin/time git clone --recurse-submodules \
    https://github.com/ccrma/chugins.git \
    >> $LOGFILE 2>&1
popd > /dev/null

pushd $HOME/Projects/chugins > /dev/null
  echo "" >> $LOGFILE
  echo "Building ChuGins" | tee --append $LOGFILE
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE
  echo "Installing ChuGins" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "*** Finished ChuGins ***"
