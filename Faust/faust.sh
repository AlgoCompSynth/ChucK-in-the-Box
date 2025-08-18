#! /usr/bin/env bash

set -e

echo ""
echo "*** ChuGins ***"

export LOGFILE=$LOGFILES/5_chugins.log
rm --force $LOGFILE

echo "Installing Linux dependencies"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install --assume-yes \
  >> $LOGFILE 2>&1

pushd $HOME/Projects/chugins/Faust > /dev/null
  echo "" >> $LOGFILE
  echo "Building Faust ChuGin" | tee --append $LOGFILE
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE
  echo "Installing Faust ChuGin" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "*** Finished ChuGins ***"
