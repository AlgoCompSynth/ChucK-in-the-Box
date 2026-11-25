#! /usr/bin/env bash

set -e

echo ""
echo "** ChucK **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/chuck.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

pushd $CHUCK_PATH > /dev/null
  echo "Checking out $CHUCK_SOURCE_VERSION"
  git checkout $CHUCK_SOURCE_VERSION \
    >> $LOGFILE 2>&1
  echo "Building ChucK" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL $CHUCK_DRIVERS \
    >> $LOGFILE 2>&1
  echo "Installing ChucK" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Copying 'WowExample.ck' to $HOME" | tee --append $LOGFILE
cp $WOW_EXAMPLE $HOME/

echo "** Finished ChucK **" | tee --append $LOGFILE
