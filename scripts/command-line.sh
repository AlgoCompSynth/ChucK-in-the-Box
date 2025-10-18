#! /usr/bin/env bash

set -e

echo ""
echo "** Command Line Packages **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/command-line.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -qqy --no-install-recommends \
  alsa-utils \
  apt-file \
  bash-completion \
  byobu \
  curl \
  file \
  flac \
  git \
  libsox-fmt-all \
  lynx \
  mp3splt \
  plocate \
  pmidi \
  sox \
  time \
  tree \
  unzip \
  upower \
  usbutils \
  vim \
  wget \
  >> $LOGFILE 2>&1

echo "** Finished Command Line Packages **"
