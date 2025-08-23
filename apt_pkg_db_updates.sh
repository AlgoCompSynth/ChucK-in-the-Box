#! /usr/bin/env bash

set -e

echo ""
echo "*** Package Database Updates ***"

export LOGFILE=$LOGFILES/pkg_db_updates.log
rm --force $LOGFILE

echo "Updating apt-file database"
sudo apt-file update \
  >> $LOGFILE 2>&1

echo "Updating locate database"
sudo updatedb \
  >> $LOGFILE 2>&1

echo "Updating manual database"
sudo mandb \
  >> $LOGFILE 2>&1

echo "*** Finished Package Database Updates ***"
echo ""
