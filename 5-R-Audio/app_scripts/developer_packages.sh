#! /usr/bin/env bash

set -e

echo ""
echo "*** Developer Packages ***"

source ../../set_envars.sh
export LOGFILE=$LOGFILES/developer_packages.log
rm --force $LOGFILE

echo "Installing R developer packages as 'root' - this takes some time."
/usr/bin/time sudo ./developer_packages.R \
  >> $LOGFILE 2>&1

echo "Installing TinyTeX as '$USER'"
/usr/bin/time Rscript -e "tinytex::install_tinytex(force = TRUE)" \
  >> $LOGFILE 2>&1

echo "*** Finished Developer Packages ***"
