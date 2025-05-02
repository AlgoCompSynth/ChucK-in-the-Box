#! /usr/bin/env bash

set -e

echo ""
echo "*** Package Databse Updates ***"

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/apt_pkg_db_updates.log
rm --force $LOGFILE

echo "Upgrading packages"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update \
  >> $LOGFILE 2>&1
sudo apt-get upgrade -y \
  >> $LOGFILE 2>&1

echo "Updating apt-file database"
sudo apt-file update \
  >> $LOGFILE 2>&1

echo "Updating locate database"
sudo updatedb \
  >> $LOGFILE 2>&1

echo "Updating manual database"
sudo mandb \
  >> $LOGFILE 2>&1

echo "Finished"
