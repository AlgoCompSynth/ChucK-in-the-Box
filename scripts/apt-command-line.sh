#! /usr/bin/env bash

set -e

echo ""
echo "** Command Line Packages **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/apt-command-line.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -qqy --no-install-recommends \
  apt-file \
  bash-completion \
  byobu \
  curl \
  file \
  git \
  lynx \
  plocate \
  starship \
  time \
  tree \
  unzip \
  usbutils \
  vim \
  wget \
  >> $LOGFILE 2>&1

echo "** Finished Command Line Packages **"
