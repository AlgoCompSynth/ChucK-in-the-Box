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
  clinfo \
  clpeak \
  faust \
  faust-common \
  flex \
  libfaust2 \
  libqscintilla2-qt6-dev \
  libssl-dev \
  libtinfo-dev \
  llvm-dev \
  pocl-opencl-icd \
  qt6-base-dev \
  qt6-base-dev-tools \
  qt6-wayland \
  zlib1g-dev \
  >> $LOGFILE 2>&1

echo "*** Finished Linux Dependencies ***"
