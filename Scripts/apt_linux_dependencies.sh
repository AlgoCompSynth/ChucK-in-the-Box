#! /usr/bin/env bash

set -e

echo ""
echo "*** miniAudicle Build Dependencies ***"

mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/linux_dependencies.log
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  bison \
  faust \
  faust-common \
  flex \
  libasound2-dev \
  libfaust2 \
  libfluidsynth-dev \
  libqscintilla2-qt6-dev \
  libsndfile1-dev \
  libssl-dev \
  libtinfo-dev \
  libzstd-dev \
  llvm \
  llvm-dev \
  qt6-base-dev \
  qt6-base-dev-tools \
  qt6-wayland \
  zlib1g-dev \
  >> $LOGFILE 2>&1

echo "Finished"
