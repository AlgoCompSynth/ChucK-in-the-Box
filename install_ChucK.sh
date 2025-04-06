#! /usr/bin/env bash

set -e

echo "Defining environment variables"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_ChucK.log
rm --force $LOGFILE
export CHUCK_VERSION="main"

echo "Installing build dependencies"
sudo apt-get update -qq
/usr/bin/time sudo apt-get upgrade --yes \
  >> $LOGFILE 2>&1
/usr/bin/time sudo apt-get install --yes \
  alsa-utils \
  apt-file \
  bison \
  build-essential \
  flex \
  libasound2-dev \
  libjack-jackd2-dev \
  libpulse-dev \
  libsndfile1-dev \
  plocate \
  >> $LOGFILE 2>&1

echo "Cloning repositories"
pushd /tmp
rm -fr miniAudicle
/usr/bin/time git clone --recurse-submodules --branch $CHUCK_VERSION \
  https://github.com/ccrma/miniAudicle.git \
  >> $LOGFILE 2>&1
popd
exit

echo ""
echo "Building ChucK"
pushd /tmp/miniAudicle/src/chuck/src
/usr/bin/time make linux-pulse \
  >> $LOGFILE 2>&1
echo ""
echo "Installing ChucK"
sudo make install \
  >> $LOGFILE 2>&1
popd

echo ""
echo "Building ChuGins"
pushd /tmp/miniAudicle/src/chugins
/usr/bin/time make linux \
  >> $LOGFILE 2>&1
echo ""
echo "Installing ChuGins"
sudo make install \
  >> $LOGFILE 2>&1
popd

echo "Finished"
