#! /usr/bin/env bash

set -eu

echo ""
echo "** Clone CCRMA Repos **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/clone-ccrma-repos.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

pushd $PROJECTS > /dev/null
  echo "Cloning $CHUCK_URL" | tee --append $LOGFILE
  rm -fr $CHUCK_PATH
  /usr/bin/time git clone --recurse-submodules --branch $CHUCK_VERSION $CHUCK_URL \
    >> $LOGFILE 2>&1

  echo "Cloning $CHUGINS_URL" | tee --append $LOGFILE
  rm -fr $CHUGINS_PATH
  /usr/bin/time git clone --recurse-submodules --branch $CHUGINS_VERSION $CHUGINS_URL \
    >> $LOGFILE 2>&1

  echo "Cloning $CHUGL_URL" | tee --append $LOGFILE
  rm -fr $CHUGL_PATH
  /usr/bin/time git clone --recurse-submodules --branch $CHUGL_VERSION $CHUGL_URL \
    >> $LOGFILE 2>&1

  echo "Cloning $CHUMP_URL" | tee --append $LOGFILE
  rm -fr $CHUMP_PATH
  /usr/bin/time git clone --recurse-submodules --branch $CHUMP_VERSION $CHUMP_URL \
    >> $LOGFILE 2>&1

popd > /dev/null

echo "** Finished Clone CCRMA Repos **" | tee --append $LOGFILE
