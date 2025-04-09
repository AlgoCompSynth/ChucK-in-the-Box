#! /usr/bin/env bash

set -e

echo "Setting environment variables"
export CHUCK_VERSION="chuck-1.5.5.0"

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/3_ChucK.log
rm --force $LOGFILE

echo ""
echo ""
echo "Installing 'jackd2' first. There appears to be no way"
echo "to keep it from configuring the realtime process priority"
echo "option when the install runs in the background."
echo ""
echo "The default of 'No' is safest; if you want to experiment"
echo "with realtime priority later, you can change it by running"
echo ""
echo "    sudo dpkg-reconfigure jackd2"
echo ""
read -p "Press 'Enter' to continue:"
sudo apt-get install --assume-yes --no-install-recommends jackd2

echo "Adding $USER to the audio group"
sudo usermod --append --groups audio $USER

echo "Installing build dependencies"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install --assume-yes --no-install-recommends \
  alsa-utils \
  bison \
  flex \
  jack-tools \
  libasound2-dev \
  libjack-jackd2-dev \
  libsndfile1-dev \
  >> $LOGFILE 2>&1

mkdir --parents $HOME/Projects
pushd $HOME/Projects
  echo ""
  echo "Cloning repositories"
  rm -fr miniAudicle
  /usr/bin/time git clone --recurse-submodules \
    https://github.com/ccrma/miniAudicle.git \
    >> $LOGFILE 2>&1
popd

pushd $HOME/Projects/miniAudicle/src/chuck/src
  echo ""
  echo "Building ChucK"
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=1 linux-jack \
    >> $LOGFILE 2>&1
  echo ""
  echo "Installing ChucK"
  sudo make install \
    >> $LOGFILE 2>&1
popd

pushd $HOME/Projects/miniAudicle/src/chugins
  echo ""
  echo "Building ChuGins"
  git checkout $CHUCK_VERSION \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=1 linux \
    >> $LOGFILE 2>&1
  echo ""
  echo "Installing ChuGins"
  sudo make install \
    >> $LOGFILE 2>&1
popd

echo "Finished"
