#! /usr/bin/env bash

set -e

echo ""
echo "*** Faust ChuGin ***"

source ../set_envars.sh
export LOGFILE=$LOGFILES/faust-chugin.log
rm --force $LOGFILE

if [[ "$CODENAME" != "bookworm" ]]
then
  echo "Installing libfaust-static"
  /usr/bin/time sudo apt-get install -qqy --no-install-recommends \
    libfaust-static \
    >> $LOGFILE 2>&1

fi

echo "Installing Faust and build dependencies" | tee --append $LOGFILE
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  faust \
  faust-common \
  libncurses-dev \
  libssl-dev \
  zlib1g-dev \
  >> $LOGFILE 2>&1

export LLVM_VERSION=$(faust --version | grep "LLVM version" | sed "s/^.*version //" | sed "s/\..*$//")
echo "LLVM_VERSION: $LLVM_VERSION"
echo "Installing LLVM"
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  llvm-$LLVM_VERSION \
  llvm-$LLVM_VERSION-dev \
  >> $LOGFILE 2>&1
export PATH=/usr/lib/llvm-$LLVM_VERSION/bin:$PATH

if [[ "$LOW_CAPACITY_SYSTEM" == "0" ]]
then
  echo "Installing FaustWorks"
  /usr/bin/time sudo apt-get install -qqy --no-install-recommends \
    faustworks \
    >> $LOGFILE 2>&1

fi

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
