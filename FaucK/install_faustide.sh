#! /usr/bin/env bash

set -e

echo ""
echo "*** FaustIDE ***"

export FAUSTIDE_URL="https://github.com/grame-cncm/faustide.git --depth 1"
export FAUSTIDE_PATH="$HOME/Projects/faustide"
export FAUSTIDE_SCRIPT=$PWD/FaustIDE

mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/install_faustide.log
rm --force $LOGFILE

# https://github.com/grame-cncm/faustlive/blob/master/Build/README.md
mkdir --parents $FAUSTIDE_PATH
rm --force --recursive $FAUSTIDE_PATH
echo "Cloning FaustIDE source repo"
pushd $HOME/Projects > /dev/null
  /usr/bin/time git clone $FAUSTIDE_URL \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "Building FaustIDE"
pushd $FAUSTIDE_PATH > /dev/null
  /usr/bin/time npm install \
    >> $LOGFILE 2>&1
  /usr/bin/time npm update \
    >> $LOGFILE 2>&1
  /usr/bin/time npm run build \
    >> $LOGFILE 2>&1
  echo "Installing FaustIDE"
  cp $FAUSTIDE_SCRIPT $HOME/.local/bin
popd > /dev/null

echo "Finished"
