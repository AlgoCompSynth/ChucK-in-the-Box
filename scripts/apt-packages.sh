#! /usr/bin/env bash

set -e

echo ""
echo "** Apt Packages **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/apt-packages.log
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
  podman \
  time \
  tree \
  uidmap \
  unzip \
  usbutils \
  vim \
  wget \
  >> $LOGFILE 2>&1

echo "** Finished Apt Packages **"
