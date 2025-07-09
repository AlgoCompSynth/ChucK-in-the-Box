#! /usr/bin/env bash

set -e

echo ""
echo "*** Linux Dependencies ***"

mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/linux_dependencies.log
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  clang-15 \
  libclang-common-15-dev \
  libclang-cpp15-dev \
  libclang-15-dev \
  libhwloc-dev \
  libllvmspirvlib-15-dev \
  llvm-15-dev \
  llvm-15-linker-tools \
  llvm-15-runtime \
  llvm-15-tools \
  llvm-spirv-15 \
  ocl-icd-dev \
  ocl-icd-libopencl1 \
  ocl-icd-opencl-dev \
  spirv-tools \
  zlib1g-dev \
  >> $LOGFILE 2>&1

echo "Finished"
