#! /usr/bin/env bash

set -e

echo ""
echo "*** Faust ChuGin ***"

source ../set_envars.sh
export LOGFILE=$LOGFILES/faust-chugin.log
rm --force $LOGFILE

if [[ "$(lsb_release --codename --short)" != "bookworm" ]]
then
  echo "Installing libfaust-static"
  /usr/bin/time sudo apt-get install -qqy --no-install-recommends \
    libfaust-static \
    >> $LOGFILE 2>&1
  export LLVM_VERSION=19

else
  export LLVM_VERSION=14

fi
echo "LLVM_VERSION: $LLVM_VERSION"

echo "Installing Linux dependencies" | tee --append $LOGFILE
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  faust \
  faust-common \
  libncurses-dev \
  libssl-dev \
  llvm-$LLVM_VERSION \
  zlib1g-dev \
  >> $LOGFILE 2>&1
export PATH=/usr/lib/llvm-$LLVM_VERSION/bin:$PATH

pushd $PROJECTS/chugins/Faust > /dev/null
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
