#! /usr/bin/env bash

set -e

echo ""
echo "*** Faust ChuGin ***"

source ../../set_envars.sh
export LOGFILE=$LOGFILES/faust-chugin.log
rm --force $LOGFILE

echo "Installing Linux dependencies" | tee --append $LOGFILE
/usr/bin/time sudo apt-get install --assume-yes \
  faust \
  faust-common \
  libncurses-dev \
  libssl-dev \
  llvm-$LLVM_VERSION \
  >> $LOGFILE 2>&1
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
