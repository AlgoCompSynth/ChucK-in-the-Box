#! /usr/bin/env bash

set -e

echo ""
echo "*** VCVRack ***"

mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_vcvrack.log
rm --force $LOGFILE

mkdir --parents $HOME/Projects
echo "Cloning repositories"
pushd $HOME/Projects > /dev/null
  rm --force --recursive Rack Fundamental VCVBook 

  /usr/bin/time git clone --branch v2.6.3 \
    https://github.com/VCVRack/Rack.git \
    >> $LOGFILE 2>&1
  cd Rack
    git submodule update --init --recursive \
      >> $LOGFILE 2>&1
  cd ..

  /usr/bin/time git clone --branch v2.6.3 \
    https://github.com/VCVRack/Fundamental.git \
    >> $LOGFILE 2>&1
  cd Fundamental
    git submodule update --init --recursive \
      >> $LOGFILE 2>&1
  cd ..

  /usr/bin/time git clone \
    https://github.com/LOGUNIVPM/VCVBook.git \
    >> $LOGFILE 2>&1

popd > /dev/null

echo "make dep" | tee --append $LOGFILE
pushd $HOME/Projects/Rack > /dev/null
  /usr/bin/time make dep \
    >> $LOGFILE 2>&1

  echo "make" | tee --append $LOGFILE
  /usr/bin/time make --jobs=`nproc` \
    >> $LOGFILE 2>&1

popd > /dev/null

echo "Building Fundamental plugin"
cp -rp $HOME/Projects/Fundamental $HOME/Projects/Rack/plugins/
pushd $HOME/Projects/Rack/plugins/Fundamental > /dev/null
  /usr/bin/time make dep \
    >> $LOGFILE 2>&1
  /usr/bin/time make --jobs=`nproc` \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Building VCVBook ABC plugin"
cp -rp $HOME/Projects/VCVBook/ABC $HOME/Projects/Rack/plugins/
pushd $HOME/Projects/Rack/plugins/ABC > /dev/null
  /usr/bin/time make --jobs=`nproc` \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Installing 'Rack' script"
cp Rack $HOME/.local/bin/

echo "Finished"
