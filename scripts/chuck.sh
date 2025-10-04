#! /usr/bin/env bash

set -e

echo ""
echo "** ChucK **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/chuck.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo "Checking out $CHUCK_SOURCE_VERSION"
pushd $MINIAUDICLE_PATH/.. > /dev/null
  git checkout $CHUCK_SOURCE_VERSION \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Installing Linux dependencies"
sudo apt-get install -qqy --no-install-recommends \
  bison \
  build-essential \
  cmake \
  flex \
  libasound2-dev \
  libjack-jackd2-dev \
  libpulse-dev \
  libsndfile1-dev \
  >> $LOGFILE 2>&1

pushd $CHUCK_PATH > /dev/null
  echo "Building ChucK" | tee --append $LOGFILE
  if [[ $MAKE_PARALLEL_LEVEL != "1" ]]
  then 
    /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL $CHUCK_DRIVERS \
      >> $LOGFILE 2>&1

  else
    /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL $CHUCK_DRIVERS \
      2>&1 | tee --append $LOGFILE

  fi
  echo "Installing ChucK" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "** Finished ChucK **" | tee --append $LOGFILE
