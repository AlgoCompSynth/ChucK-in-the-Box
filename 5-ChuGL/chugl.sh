#! /usr/bin/env bash

set -e

echo ""
echo "*** ChuGL ***"

source ../set_envars.sh
export LOGFILE=$LOGFILES/chugl.log
rm --force $LOGFILE

echo "Installing Linux dependencies"
/usr/bin/time sudo apt-get install --assume-yes \
  libcanberra-gtk3-module \
  libgl-dev \
  libwayland-bin \
  libwayland-dev \
  libx11-dev \
  libxcursor-dev \
  libxi-dev \
  libxinerama-dev \
  libxkbcommon-x11-dev \
  libxrandr-dev \
  >> $LOGFILE 2>&1

echo "" >> $LOGFILE
echo "Cloning ChuGL repository" | tee --append $LOGFILE
pushd $HOME/Projects > /dev/null
  rm -fr chugl
  /usr/bin/time git clone --recurse-submodules \
    --branch $CHUGL_VERSION \
    https://github.com/ccrma/chugl.git \
    >> $LOGFILE 2>&1
  cd chugl/examples/basic
  wget --quiet https://ccrma.stanford.edu/~azaday/music/khrang.wav
popd > /dev/null

pushd $HOME/Projects/chugl/src > /dev/null
  echo "" >> $LOGFILE
  echo "Building ChuGL" | tee --append $LOGFILE
  /usr/bin/time make linux \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE
  echo "Installing ChuGL" | tee --append $LOGFILE
  sudo cp ChuGL.chug $CHUGIN_PATH/
popd > /dev/null

echo "*** Finished ChuGL ***" | tee --append $LOGFILE
