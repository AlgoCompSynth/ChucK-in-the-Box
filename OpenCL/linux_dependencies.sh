#! /usr/bin/env bash

set -e

echo ""
echo "*** Linux Dependencies ***"

mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/linux_dependencies.log
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
# https://portablecl.org/docs/html/install.html
export LLVM_VERSION=19
/usr/bin/time sudo apt-get install -qqy \
  apt-utils \
  build-essential \
  clang-${LLVM_VERSION} \
  clinfo \
  cmake \
  dialog \
  git \
  libclang-${LLVM_VERSION}-dev \
  libclang-cpp${LLVM_VERSION} \
  libclang-cpp${LLVM_VERSION}-dev \
  libhwloc-dev \
  libpython3-dev \
  libxml2-dev \
  llvm-${LLVM_VERSION} \
  llvm-${LLVM_VERSION}-dev
  make \
  ninja-build \
  ocl-icd-dev \
  ocl-icd-libopencl1 \
  ocl-icd-libopencl1 \
  ocl-icd-opencl-dev \
  pkg-config \
  python3-dev \
  zlib1g \
  zlib1g-dev \
  >> $LOGFILE 2>&1

echo "*** Finished Linux Dependencies ***"
