#! /usr/bin/env bash

set -e

echo ""
echo "** ChucK **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/chuck.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo "Installing ChucK and build dependencies"
sudo apt-get install -qqy --no-install-recommends \
  bison \
  build-essential \
  chuck \
  cmake \
  flex \
  libasound2-dev \
  libjack-jackd2-dev \
  libpulse-dev \
  libsndfile1-dev \
  pkgconf \
  >> $LOGFILE 2>&1

cp scripts/probe-ChucK.sh $LOCALBIN
cp scripts/list-alsa-cards.sh $LOCALBIN

echo "** Finished ChucK **" | tee --append $LOGFILE
