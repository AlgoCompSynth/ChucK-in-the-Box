#! /usr/bin/env bash

set -e

echo ""
echo "*** PoCL, clinfo, and clpeak ***"

echo "Setting URLs"
export POCL_URL="--branch v7.0 https://github.com/pocl/pocl.git"
export CLINFO_URL="--branch 3.0.25.02.14 https://github.com/Oblomov/clinfo.git"
export CLPEAK_URL="--branch 1.1.4 https://github.com/krrishnarraj/clpeak.git"

mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_opencl.log
rm --force $LOGFILE

mkdir --parents $HOME/Projects
echo "Cloning repositories"
pushd $HOME/Projects > /dev/null
  rm -fr pocl clinfo clpeak
  /usr/bin/time git clone $POCL_URL \
    >> $LOGFILE 2>&1
  /usr/bin/time git clone $CLINFO_URL \
    >> $LOGFILE 2>&1
  /usr/bin/time git clone $CLPEAK_URL \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Building PoCL"
pushd $HOME/Projects/pocl > /dev/null
  mkdir build; cd build; cmake .. \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=`nproc` \
    >> $LOGFILE 2>&1
  echo "Installing Pocl"
  sudo make install \
    >> $LOGFILE 2>&1
  sudo mkdir --parents /etc/OpenCL/vendors/
  sudo cp pocl.icd /etc/OpenCL/vendors/
popd > /dev/null

echo "Building clinfo"
pushd $HOME/Projects/clinfo > /dev/null
  /usr/bin/time make \
    >> $LOGFILE 2>&1
  echo "Installing clinfo"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null
echo ""
echo "clinfo --list"
clinfo --list
echo ""

echo "Building clpeak"
pushd $HOME/Projects/clpeak > /dev/null
  /usr/bin/time git submodule update --init --recursive --remote \
    >> $LOGFILE 2>&1
  mkdir build
  cd build
  cmake .. \
    >> $LOGFILE 2>&1
  /usr/bin/time cmake --build . \
    >> $LOGFILE 2>&1
  echo "Installing clpeak"
  sudo make install \
    >> $LOGFILE 2>&1
popd > /dev/null

# at most three platforms; clpeak aborts on first bad one
for i in 0 1 2
do
  clpeak --platform $i --compute-sp 2>&1 | tee --append $LOGFILE
done

echo "Finished"
