#! /usr/bin/env bash

set -e

echo ""
echo "** Upgrade System **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/upgrade-system.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

# https://debian-handbook.info/browse/stable/sect.automatic-upgrades.html
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update -qq \
  >> $LOGFILE 2>&1
yes '' | sudo apt-get -qqy \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  upgrade \
  >> $LOGFILE 2>&1
sudo apt-get -qqy autoremove \
  >> $LOGFILE 2>&1

echo "** Finished Upgrade System **" | tee --append $LOGFILE
