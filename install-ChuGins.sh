#! /usr/bin/env bash

set -e

echo ""
echo "* ChuGins *"

source ./set_envars.sh
export LOGFILE=$LOGFILES/install-ChuGins.log
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

echo "Installing ChuGins build dependencies" | tee --append $LOGFILE
sudo apt-get install -qqy --no-install-recommends \
  build-essential \
  cmake \
  >> $LOGFILE 2>&1

pushd $CHUGINS_PATH > /dev/null
  echo "" | tee --append $LOGFILE
  echo "Building default ChuGins" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux \
    >> $LOGFILE 2>&1
  echo "Installing default ChuGins" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "" | tee --append $LOGFILE
echo "Installing FluidSynth ChuGin build dependencies" | tee --append $LOGFILE
sudo apt-get install -qqy --no-install-recommends \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  fluidsynth \
  libfluidsynth-dev \
  opl3-soundfont \
  polyphone \
  >> $LOGFILE 2>&1

pushd $CHUGINS_PATH/FluidSynth > /dev/null
  echo "Building FluidSynth ChuGin" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux \
    >> $LOGFILE 2>&1
  echo "Installing FluidSynth ChuGin" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "" | tee --append $LOGFILE
pushd $CHUGINS_PATH/WarpBuf > /dev/null
  echo "Configuring WarpBuf ChuGin" | tee --append $LOGFILE
  rm --force --recursive build; mkdir --parents build; cd build
  /usr/bin/time cmake .. \
    >> $LOGFILE 2>&1
  echo "Building WarpBuf ChuGin" | tee --append $LOGFILE
  /usr/bin/time make \
    >> $LOGFILE 2>&1
  echo "Installing WarpBuf ChuGin" | tee --append $LOGFILE
  sudo cp WarpBuf.chug $CHUGINS_LIB_PATH/
    >> $LOGFILE 2>&1
popd > /dev/null

echo "" | tee --append $LOGFILE
echo "Installing Faust ChuGin build dependencies" | tee --append $LOGFILE
sudo apt-get install -qqy --no-install-recommends \
  faust \
  "libfaust*" \
  libssl-dev \
  >> $LOGFILE 2>&1
faust --version > faust-version.log
export LLVM_VERSION=$(grep "LLVM version" faust-version.log | sed 's/^.*version //' | sed 's/\..*$//')
sudo apt-get install -qqy --no-install-recommends \
  llvm-${LLVM_VERSION}-dev \
  >> $LOGFILE 2>&1
export PATH=/usr/lib/llvm-${LLVM_VERSION}/bin:$PATH

pushd $CHUGINS_PATH/Faust > /dev/null
  echo "Building Faust ChuGin" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux \
    >> $LOGFILE 2>&1
  echo "Installing Faust ChuGin" | tee --append $LOGFILE
  sudo cp Faust.chug $CHUGINS_LIB_PATH/
popd > /dev/null

echo "" | tee --append $LOGFILE
echo "chuck --probe" | tee --append $LOGFILE
chuck --probe | tee --append $LOGFILE > chuck-probe.log
echo "chuck --chugin-probe" | tee --append $LOGFILE
chuck --chugin-probe | tee --append $LOGFILE >> chuck-probe.log

echo "* Finished ChuGins *" | tee --append $LOGFILE
echo ""
