#! /usr/bin/env bash

set -e

echo ""
echo "*** ChucK ***"

export CHUCK_VERSION="chuck-1.5.5.2"
export MAKE_PARALLEL_LEVEL=$(nproc)
#export MAKE_PARALLEL_LEVEL=1 # for low-RAM systems
export LOGFILES=$HOME/Logfiles

export LOGFILE=$LOGFILES/chuck.log
rm --force $LOGFILE

echo "Installing Linux dependencies" | tee --append $LOGFILE
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install --assume-yes \
  bison \
  build-essential \
  flex \
  libasound2-dev \
  libjack-jackd2-dev \
  libpulse-dev \
  libsndfile1-dev \
  >> $LOGFILE 2>&1

echo "" >> $LOGFILE
echo "Cloning chuck repository" | tee --append $LOGFILE
pushd $HOME/Projects > /dev/null
  rm -fr chuck
  /usr/bin/time git clone \
    --branch ${CHUCK_VERSION} \
    https://github.com/ccrma/chuck.git \
    >> $LOGFILE 2>&1
popd > /dev/null

pushd $HOME/Projects/chuck/src > /dev/null
  echo "" >> $LOGFILE
  echo "Building ChucK" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux-all \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE
  echo "Installing ChucK" | tee --append $LOGFILE
  make DESTDIR=$HOME/.local/bin install \
    >> $LOGFILE 2>&1
popd > /dev/null

pushd $HOME/Projects/chuck/examples/book/digital-artists/chapter1 > /dev/null
  echo "" >> $LOGFILE
  echo "Testing ChucK" | tee --append $LOGFILE
  echo "You should hear random notes"
  echo "Press 'CTRL-C' to exit"
  sleep 5
  chuck WowExample.ck
  sleep 5
popd > /dev/null

echo "*** Finished ChucK ***"
