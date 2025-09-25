#! /usr/bin/env bash

set -e

echo ""
echo "* ChucK and ChuGins *"

source ./set_envars.sh
export LOGFILE=$LOGFILES/install-ChucK-ChuGins.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

pushd $CHUCK_PATH > /dev/null
  echo "Building ChucK" | tee --append $LOGFILE
  if [[ $MAKE_PARALLEL_LEVEL != "1" ]]
  then 
    /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL $CHUCK_DRIVERS \
      >> $LOGFILE 2>&1

  else
    /usr/bin/time make --jobs=$MAKE_PARALLEL_LEVEL $CHUCK_DRIVERS \
      2>&1 | tee --append $LOGFILE

  fi
  echo "Installing ChucK" | tee --append $LOGFILE
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Exporting ChucK to host" | tee --append $LOGFILE
distrobox-export --bin "$(which chuck)"

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
echo "Getting LLVM version" | tee --append $LOGFILE
faust --version > faust-version.log
export LLVM_VERSION=$(grep "LLVM version" faust-version.log | sed 's/^.*version //' | sed 's/\..*$//')
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

echo "* Finished ChucK and ChuGins *" | tee --append $LOGFILE
echo ""
