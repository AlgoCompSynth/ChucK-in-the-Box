#! /usr/bin/env bash

set -e

echo ""
echo "** Clone CCRMA Repos **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/clone-ccrma-repos.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo "Recursively cloning miniAudicle repository - this takes some time" | tee --append $LOGFILE
pushd $PROJECTS > /dev/null
  rm -fr miniAudicle
  /usr/bin/time git clone \
    --recurse-submodules \
    --branch $CHUCK_VERSION \
    https://github.com/ccrma/miniAudicle.git \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "** Finished Clone CCRMA Repos **" | tee --append $LOGFILE
