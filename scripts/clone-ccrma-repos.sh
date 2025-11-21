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
    https://github.com/ccrma/miniAudicle.git \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Cloning chugl repository" | tee --append $LOGFILE
pushd $PROJECTS > /dev/null
  rm -fr chugl
  /usr/bin/time git clone \
    https://github.com/ccrma/chugl.git \
    >> $LOGFILE 2>&1

  echo "Downloading 'lissajous' audio file"
  cd chugl/examples/basic
  wget --quiet https://ccrma.stanford.edu/~azaday/music/khrang.wav

popd > /dev/null

echo "** Finished Clone CCRMA Repos **" | tee --append $LOGFILE
