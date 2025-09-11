#! /usr/bin/env bash

set -e

echo ""
echo "* ChucK and ChuGins *"

source ./set_envars.sh
export LOGFILE=$LOGFILES/chuck-and-chugins.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo "Installing dependencies" | tee --append $LOGFILE
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  alsa-utils \
  apt-file \
  bash-completion \
  bison \
  build-essential \
  ca-certificates \
  cmake \
  curl \
  file \
  flex \
  git \
  jacktrip \
  libasound2-dev \
  libjack-jackd2-dev \
  libsndfile1-dev \
  lsb-release \
  lynx \
  pkg-config \
  plocate \
  time \
  tree \
  unzip \
  vim \
  wget \
  >> $LOGFILE 2>&1

sudo apt-file update \
  >> $LOGFILE 2>&1
  
echo "Joining the host groups"
sudo /usr/sbin/usermod --append --groups adm,dialout,cdrom,sudo,audio,video,plugdev,games,users $USER

echo "Recursively cloning miniAudicle repository - this takes some time" | tee --append $LOGFILE
pushd $PROJECTS > /dev/null
  rm -fr miniAudicle
  /usr/bin/time git clone \
    --recurse-submodules \
    --branch $CHUCK_VERSION \
    https://github.com/ccrma/miniAudicle.git \
    >> $LOGFILE 2>&1
popd > /dev/null

pushd $CHUCK_PATH > /dev/null
  echo "Building ChucK" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL $CHUCK_DRIVERS \
    >> $LOGFILE 2>&1
  echo "Installing ChucK" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null
echo "chuck --probe" | tee --append $LOGFILE
chuck --probe | tee --append $LOGFILE

pushd $CHUGINS_PATH > /dev/null
  echo "" | tee --append $LOGFILE
  echo "Building ChuGins" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux \
    >> $LOGFILE 2>&1
  echo "Installing ChuGins" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null
echo "chuck --chugin-probe" | tee --append $LOGFILE
chuck --chugin-probe | tee --append $LOGFILE

echo "* Finished ChucK and ChuGins *" | tee --append $LOGFILE
