#! /usr/bin/env bash

set -e

echo ""
echo "*** ChuGL ***"

source ../set_envars.sh
export LOGFILE=$LOGFILES/chugl-both-release-$(hostname).log
rm --force $LOGFILE

echo "Installing Linux dependencies"
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
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

./package-versions.sh

echo "" >> $LOGFILE
echo "Cloning ChuGL repository" | tee --append $LOGFILE
pushd $PROJECTS > /dev/null
  rm -fr chugl
  /usr/bin/time git clone --recurse-submodules \
    --branch $CHUGL_VERSION \
    https://github.com/ccrma/chugl.git \
    >> $LOGFILE 2>&1
  cd chugl/examples/basic
  wget --quiet https://ccrma.stanford.edu/~azaday/music/khrang.wav
popd > /dev/null

pushd $PROJECTS/chugl/src > /dev/null
  echo "" >> $LOGFILE
  echo "Building ChuGL" | tee --append $LOGFILE
  cmake -B build-release -DCMAKE_BUILD_TYPE=Release \
    >> $LOGFILE 2>&1
  cd build-release
  /usr/bin/time make \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE
  echo "Installing ChuGL" | tee --append $LOGFILE
  sudo mkdir --parents $CHUGIN_PATH
  sudo cp ChuGL.chug $CHUGIN_PATH/
popd > /dev/null

echo "Testing"
export RUST_BACKTRACE=full
echo "ChuGin probe"
chuck --chugin-probe 2>&1 | tee --append $LOGFILE || true
echo "Minimal example - ESC to exit"
chuck startup-test.ck 2>&1 | tee --append $LOGFILE || true

echo "Complex example - runs in bookworm container and crashes in PiOS host"
pushd $PROJECTS/chugl/examples/basic
  chuck lissajous.ck 2>&1 | tee --append $LOGFILE || true
popd

echo "*** Finished ChuGL ***" | tee --append $LOGFILE
