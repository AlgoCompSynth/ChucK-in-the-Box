#! /usr/bin/env bash

set -e

echo ""
echo "*** Linux Dependencies ***"

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/linux_dependencies.log
rm --force $LOGFILE

echo "Installing Linux build dependencies"
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
  llvm \
  >> $LOGFILE 2>&1

echo "Finished"
