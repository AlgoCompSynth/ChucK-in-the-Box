#! /usr/bin/env bash

set -e

echo ""
echo "*** Portable Compute Language (PoCL) ***"

mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_pocl.log
rm --force $LOGFILE

echo "Installing Linux build dependencies"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install -qqy --no-install-recommends \
  clinfo \
  clpeak \
  pocl-doc \
  pocl-opencl-icd \
  >> $LOGFILE 2>&1

echo "Measuring OpenCL peaks"
clpeak --platform 0 \
  2>&1 | tee --append $LOGFILE

echo "Finished"
