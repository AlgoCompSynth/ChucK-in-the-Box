#! /usr/bin/env bash

set -e

echo ""
echo "*** ChucK ***"

source ../set_envars.sh
export LOGFILE=$LOGFILES/chuck.log
rm --force $LOGFILE

echo "Installing Linux dependencies" | tee --append $LOGFILE
/usr/bin/time sudo apt-get install --assume-yes \
  bison \
  build-essential \
  flex \
  libasound2-dev \
  libsndfile1-dev \
  >> $LOGFILE 2>&1

echo "" >> $LOGFILE
echo "Cloning chuck repository" | tee --append $LOGFILE
pushd $PROJECTS > /dev/null
  rm -fr chuck
  /usr/bin/time git clone \
    --branch ${CHUCK_VERSION} \
    https://github.com/ccrma/chuck.git \
    >> $LOGFILE 2>&1
popd > /dev/null

pushd $PROJECTS/chuck/src > /dev/null
  echo "" >> $LOGFILE
  echo "Building ChucK" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux-alsa \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE
  echo "Installing ChucK" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

pushd $PROJECTS/chuck/examples/book/digital-artists/chapter1 > /dev/null
  echo "" >> $LOGFILE
  echo "Testing ChucK" | tee --append $LOGFILE
  echo "You should hear random notes"
  echo "Press 'CTRL-C' to exit"
  sleep 5
  chuck WowExample.ck || true
  sleep 5
popd > /dev/null

echo "*** Finished ChucK ***" | tee --append $LOGFILE
