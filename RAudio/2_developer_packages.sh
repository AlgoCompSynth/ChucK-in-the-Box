#! /usr/bin/env bash

set -e

echo ""
echo "*** Developer Packages ***"

export LOGFILE=$PWD/Logs/developer_packages.log
rm --force $LOGFILE

echo "Installing Linux dependencies"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install --yes \
  libcurl4-openssl-dev \
  libfontconfig1-dev \
  libfreetype6-dev \
  libfribidi-dev \
  libgit2-dev \
  libharfbuzz-dev \
  libjpeg-dev \
  libmagick++-dev \
  libpng-dev \
  libtiff5-dev \
  libunistring-dev \
  libxml2-dev \
  >> $LOGFILE 2>&1

echo "Installing R developer packages - this takes some time."
/usr/bin/time ./developer_packages.R \
  >> $LOGFILE 2>&1

echo "Finished"
