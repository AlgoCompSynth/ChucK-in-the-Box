#! /usr/bin/env bash

set -e

echo ""
echo "** Faust ChuGin **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/faust-chugin.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo "Installing Faust and Linux dependencies"
sudo apt-get install -qqy --no-install-recommends \
  faust \
  libssl-dev \
  zlib1g-dev \
  >> $LOGFILE 2>&1

if [[ "$(lsb_release -sc 2> /dev/null)" != "bookworm" ]]
then
  sudo apt-get install -qqy --no-install-recommends \
    libfaust-static \
    >> $LOGFILE 2>&1

fi

echo "Getting LLVM version" | tee --append $LOGFILE
export LLVM_VERSION="$(faust --version 2>&1 | grep 'LLVM version' | sed 's/^.*version //' | sed 's/\..*$//')"
echo "Installing llvm-${LLVM_VERSION}-dev"
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

echo "** Finished Faust ChuGin **" | tee --append $LOGFILE
