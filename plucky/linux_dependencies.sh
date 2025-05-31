#! /usr/bin/env bash

set -e

echo ""
echo "*** Linux Dependencies ***"

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/linux_dependencies.log
rm --force $LOGFILE

echo "Installing Linux build dependencies"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  bison \
  clinfo \
  clpeak \
  faust \
  faust-common \
  flex \
  libasound2-dev \
  libfaust2t64 \
  libfaust-static \
  libpocl2t64 \
  libsndfile1-dev \
  libssl-dev \
  libtinfo-dev \
  pocl-opencl-icd \
  >> $LOGFILE 2>&1

echo "Measuring OpenCL peaks"
clpeak --platform 0 --compute-sp \
  2>&1 | tee --append $LOGFILE
clpeak --platform 0 --compute-integer \
  2>&1 | tee --append $LOGFILE

echo "Finished"
