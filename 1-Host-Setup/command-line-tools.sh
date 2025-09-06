#! /usr/bin/env bash

set -e

echo ""
echo "*** Command Line Tools ***"

sudo apt-get update -qq \
  >> $LOGFILE 2>&1
sudo apt-get install -qqy --no-install-recommends \
  apt-file \
  bash-completion \
  bluetooth \
  build-essential \
  ca-certificates \
  cmake \
  curl \
  file \
  git \
  lsb-release \
  lynx \
  pipewire-alsa \
  pipewire-doc \
  pkg-config \
  plocate \
  time \
  tree \
  unzip \
  usbutils \
  vim \
  wget \
  >> $LOGFILE 2>&1

echo "*** Finished Command Line Tools ***" | tee --append $LOGFILE
echo ""
