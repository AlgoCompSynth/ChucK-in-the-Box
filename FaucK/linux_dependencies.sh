#! /usr/bin/env bash

set -e

echo ""
echo "*** Linux Dependencies ***"

mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/linux_dependencies.log
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  bison \
  flex \
  libasound2-dev \
  libfluidsynth-dev \
  libmicrohttpd-dev \
  libqscintilla2-qt6-dev \
  libsndfile1-dev \
  libzstd-dev \
  llvm \
  llvm-dev \
  meson \
  npm \
  qt6-base-dev \
  qt6-base-dev-tools \
  qt6-wayland \
  >> $LOGFILE 2>&1

echo "Finished"
