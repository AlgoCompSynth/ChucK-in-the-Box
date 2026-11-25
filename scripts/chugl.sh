#! /usr/bin/env bash

set -e

echo ""
echo "*** ChuGL ***"

source ./set_envars.sh
export LOGFILE=$LOGFILES/chugl.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo "Installing Linux dependencies"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install --assume-yes \
  libcanberra-gtk3-module \
  libgl-dev \
  libv4l-dev \
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
echo "Cloning $CHUGL_URL" | tee --append $LOGFILE
pushd $HOME/Projects > /dev/null
  rm -fr $CHUGL_PATH
  /usr/bin/time git clone --recurse-submodules $CHUGL_URL \
    >> $LOGFILE 2>&1
  cd $CHUGL_PATH/examples/basic
  wget --quiet https://ccrma.stanford.edu/~azaday/music/khrang.wav
popd > /dev/null

pushd $CHUGL_PATH/src > /dev/null
  git checkout $CHUGL_VERSION \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE
  echo "Building ChuGL" | tee --append $LOGFILE
  /usr/bin/time make linux \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE
  echo "Installing ChuGL" | tee --append $LOGFILE
  sudo mkdir --parents /usr/local/lib/chuck/
  sudo cp ChuGL.chug /usr/local/lib/chuck/
popd > /dev/null

echo "" >> $LOGFILE
echo "ldconfig" | tee --append $LOGFILE
sudo /sbin/ldconfig --verbose \
  >> $LOGFILE 2>&1

echo "*** Finished ChuGL ***"
