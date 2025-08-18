#! /usr/bin/env bash

set -e

echo ""
echo "*** ChuGL ***"

export LOGFILE=$LOGFILES/7_chugl.log
rm --force $LOGFILE

#echo "Installing Linux dependencies"
#export DEBIAN_FRONTEND=noninteractive
#/usr/bin/time sudo apt-get install --assume-yes \
  #libcanberra-gtk3-module \
  #libgl-dev \
  #libwayland-bin \
  #libwayland-dev \
  #libx11-dev \
  #libxcursor-dev \
  #libxi-dev \
  #libxinerama-dev \
  #libxkbcommon-x11-dev \
  #libxrandr-dev \
  >> $LOGFILE 2>&1

echo "" >> $LOGFILE
echo "Cloning ChuGL repository" | tee --append $LOGFILE
pushd $HOME/Projects > /dev/null
  rm -fr chugl
  /usr/bin/time git clone --recurse-submodules \
    https://github.com/ccrma/chugl.git \
    >> $LOGFILE 2>&1
  cd chugl/examples/basic
  wget --quiet https://ccrma.stanford.edu/~azaday/music/khrang.wav
popd > /dev/null

pushd $HOME/Projects/chugl/src > /dev/null
  git checkout $CHUGL_VERSION \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE
  echo "Building ChuGL" | tee --append $LOGFILE
  /usr/bin/time make linux \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE
  echo "Installing ChuGL" | tee --append $LOGFILE
  sudo cp ChuGL.chug /usr/local/lib/chuck/
popd > /dev/null

echo "" >> $LOGFILE
echo "ldconfig" | tee --append $LOGFILE
sudo /sbin/ldconfig --verbose \
  >> $LOGFILE 2>&1

echo "*** Finished ChuGL ***"
