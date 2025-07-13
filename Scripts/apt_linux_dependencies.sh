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
  faust \
  faust-common \
  flex \
  libasound2-dev \
  libfaust2 \
  libsndfile1-dev \
  libssl-dev \
  libtinfo-dev \
  llvm-dev \
  zlib1g-dev \
  >> $LOGFILE 2>&1

echo "Finished"
echo "*** Finished Linux Dependencies ***"
