#! /usr/bin/env bash

set -e

echo ""
echo "*** Package Database Updates ***"

export LOGFILE=$LOGFILES/pkg_db_updates.log
rm --force $LOGFILE

echo "Updating locate database"
sudo updatedb \
  >> $LOGFILE 2>&1

echo "*** Finished Package Database Updates ***"
echo ""
