#! /usr/bin/env bash

set -e

echo ""
echo "*** Linux Dependencies ***"

mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/linux_dependencies.log
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive

if [[ `grep Intel /proc/cpuinfo | wc -l` > "0" ]]
then
  echo "Installing Intel OpenCL"
  /usr/bin/time sudo apt-get install -qqy --no-install-recommends \
    intel-opencl-icd \
    >> $LOGFILE 2>&1
fi

/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  clang \
  libclang-cpp-dev \
  libclang-dev \
  libhwloc-dev \
  llvm \
  llvm-dev \
  ocl-icd-dev \
  ocl-icd-libopencl1 \
  ocl-icd-opencl-dev \
  zlib1g-dev \
  >> $LOGFILE 2>&1

echo "Finished"
