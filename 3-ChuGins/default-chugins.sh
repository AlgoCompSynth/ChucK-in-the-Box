#! /usr/bin/env bash

set -e

echo ""
echo "*** Default ChuGins ***"

export LOGFILE=$LOGFILES/default-chugins.log
rm --force $LOGFILE

echo "" >> $LOGFILE
echo "Cloning chugins repository" | tee --append $LOGFILE
pushd $PROJECTS > /dev/null
  rm -fr chugins
  /usr/bin/time git clone \
    --recurse-submodules \
    --branch ${CHUCK_VERSION} \
    https://github.com/ccrma/chugins.git \
    >> $LOGFILE 2>&1
popd > /dev/null

pushd $PROJECTS/chugins > /dev/null
  echo "" >> $LOGFILE
  echo "Building default ChuGins" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE
  echo "Installing default ChuGins" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "*** Finished Default ChuGins ***" | tee --append $LOGFILE
echo ""
