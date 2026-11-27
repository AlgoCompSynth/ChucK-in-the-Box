#! /usr/bin/env bash

set -eu

echo ""
echo "** ChucK **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/chuck.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

pushd $PROJECTS > /dev/null
  echo "Cloning $CHUCK_URL" | tee --append $LOGFILE
  rm -fr $CHUCK_PATH
  /usr/bin/time git clone --recurse-submodules --branch $CHUCK_VERSION $CHUCK_URL \
    >> $LOGFILE 2>&1

popd > /dev/null

pushd $CHUCK_PATH > /dev/null
  echo "" >> $LOGFILE
  echo "Building ChucK" | tee --append $LOGFILE
  cd src
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL $CHUCK_DRIVERS \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE
  echo "Installing ChucK" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1

popd > /dev/null

echo "Copying 'WowExample.ck' to $HOME" | tee --append $LOGFILE
cp $WOW_EXAMPLE $HOME/

echo "** Finished ChucK **" | tee --append $LOGFILE
