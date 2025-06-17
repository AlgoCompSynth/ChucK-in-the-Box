#! /usr/bin/env bash

set -e

export LOGFILE=$PWD/Logs/R.log
rm --force $LOGFILE

echo "Installing bibtool, qpdf and R"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  bibtool \
  qpdf \
  r-base \
  r-base-dev \
  >> $LOGFILE 2>&1
echo ""
echo "R --version: `R --version`"
echo ""

echo "Setting R profiles HOME/.Rprofile and HOME/.Renviron"
cp Rprofile $HOME/.Rprofile
# https://forum.posit.co/t/timedatectl-had-status-1/72060/5
cp Renviron $HOME/.Renviron

echo "Finished"
