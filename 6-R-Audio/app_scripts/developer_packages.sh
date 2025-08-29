#! /usr/bin/env bash

set -e

echo ""
echo "*** Developer Packages ***"

source ../../set_envars.sh
export LOGFILE=$LOGFILES/developer_packages.log
rm --force $LOGFILE

echo "Installing Linux dependencies" | tee --append $LOGFILE
/usr/bin/time sudo apt-get install --assume-yes \
  libcurl4-openssl-dev \
  libfontconfig1-dev \
  libfreetype6-dev \
  libfribidi-dev \
  libharfbuzz-dev \
  libjpeg-dev \
  libpng-dev \
  libssl-dev \
  libtiff5-dev \
  libxml2-dev \
  >> $LOGFILE 2>&1

echo "Installing R developer packages - this takes some time."
/usr/bin/time sudo ./developer_packages.R \
  >> $LOGFILE 2>&1

echo "*** Finished Developer Packages ***"
