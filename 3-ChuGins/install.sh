#! /usr/bin/env bash

set -e

echo ""
echo "*** ChuGins ***"

source ../set_envars.sh
export LOGFILE=$LOGFILES/chugins.log
rm --force $LOGFILE

echo "" >> $LOGFILE
echo "Cloning chugins repository" | tee --append $LOGFILE
pushd $HOME/Projects > /dev/null
  rm -fr chugins
  /usr/bin/time git clone \
    --recurse-submodules \
    --branch ${CHUCK_VERSION} \
    https://github.com/ccrma/chugins.git \
    >> $LOGFILE 2>&1
popd > /dev/null

pushd $HOME/Projects/chugins > /dev/null
  echo "" >> $LOGFILE
  echo "Building ChuGins" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE
  echo "Installing ChuGins" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "*** Finished ChuGins ***" | tee --append $LOGFILE

echo ""
echo "*** Faust ChuGin ***"

export LOGFILE=$LOGFILES/faust-chugin.log
rm --force $LOGFILE

echo "Installing Linux dependencies" | tee --append $LOGFILE
/usr/bin/time sudo apt-get install --assume-yes \
  faust \
  faust-common \
  libncurses-dev \
  libssl-dev \
  llvm-$LLVM_VERSION \
  zlib1g-dev \
  >> $LOGFILE 2>&1

if [[ "$(lsb_release --codename --short)" != "bookworm" ]]
then
  echo "Installing libfaust-static"
  /usr/bin/time sudo apt-get install --assume-yes \
    libfaust-static \
    >> $LOGFILE 2>&1
fi
export PATH=/usr/lib/llvm-$LLVM_VERSION/bin:$PATH
echo $PATH | tee --append $LOGFILE

pushd $HOME/Projects/chugins/Faust > /dev/null
  echo "" >> $LOGFILE
  echo "Building Faust ChuGin" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE
  echo "Installing Faust ChuGin" | tee --append $LOGFILE
  sudo cp Faust.chug $CHUGIN_PATH/
popd > /dev/null

echo "*** Finished Faust ChuGin ***" | tee --append $LOGFILE

echo ""
echo "*** FluidSynth ChuGin ***"

export LOGFILE=$LOGFILES/fluidsynth-chugin.log
rm --force $LOGFILE

echo "Installing Linux dependencies" | tee --append $LOGFILE
/usr/bin/time sudo apt-get install --assume-yes \
  libfluidsynth-dev \
  >> $LOGFILE 2>&1

pushd $HOME/Projects/chugins/FluidSynth > /dev/null
  echo "" >> $LOGFILE
  echo "Building FluidSynth ChuGin" | tee --append $LOGFILE
  /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL linux \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE
  echo "Installing FluidSynth ChuGin" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "*** Finished FluidSynth ChuGin ***" | tee --append $LOGFILE

echo ""
echo "*** WarpBuf ChuGin ***"

export LOGFILE=$LOGFILES/warpbuf-chugin.log
rm --force $LOGFILE

echo "Installing Linux dependencies" | tee --append $LOGFILE
/usr/bin/time sudo apt-get install --assume-yes \
  cmake \
  libmp3lame-dev \
  libspeex-dev \
  libsqlite3-dev \
  >> $LOGFILE 2>&1

pushd $HOME/Projects/chugins/WarpBuf > /dev/null
  echo "" >> $LOGFILE
  echo "Building WarpBuf ChuGin" | tee --append $LOGFILE
  git submodule update --init --recursive \
    >> $LOGFILE 2>&1
  sh build_unix.sh \
    >> $LOGFILE 2>&1
  echo "" >> $LOGFILE
  echo "Installing WarpBuf ChuGin" | tee --append $LOGFILE
  sudo cp build/WarpBuf.chug $CHUGIN_PATH/
popd > /dev/null

echo "*** Finished WarpBuf ChuGin ***" | tee --append $LOGFILE
