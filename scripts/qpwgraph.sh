#! /usr/bin/env bash

set -e

echo ""
echo "** qpwgraph **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/qpwgraph.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -qqy \
  qpwgraph \
  >> $LOGFILE 2>&1

echo "** Finished qpwgraph **"
