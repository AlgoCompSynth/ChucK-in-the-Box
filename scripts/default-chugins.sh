#! /usr/bin/env bash

set -eu

echo ""
echo "** Default ChuGins **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/default-chugins.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

pushd $PROJECTS > /dev/null
  echo "Cloning $CHUGINS_URL" | tee --append $LOGFILE
  rm -fr $CHUGINS_PATH
  /usr/bin/time git clone --recurse-submodules --branch $CHUGINS_VERSION $CHUGINS_URL \
    >> $LOGFILE 2>&1

popd > /dev/null

pushd $CHUGINS_PATH > /dev/null
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
