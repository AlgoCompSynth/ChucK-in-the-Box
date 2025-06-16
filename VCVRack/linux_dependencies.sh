#! /usr/bin/env bash

set -e

echo ""
echo "*** Linux Dependencies ***"

mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/linux_dependencies.log
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  autoconf \
  automake \
  jq \
  libasound2-dev \
  libglew-dev \
  libjack-jackd2-dev \
  libpulse-dev \
  libtool \
  libxcursor-dev \
  libxi-dev \
  libxinerama-dev \
  libxrandr-dev \
  >> $LOGFILE 2>&1

echo "Finished"
