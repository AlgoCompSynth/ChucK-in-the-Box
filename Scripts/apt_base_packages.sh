#! /usr/bin/env bash

set -e

echo ""
echo "*** Base Packages ***"

mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/base_packages.log"
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
sudo apt-get install --assume-yes --no-install-recommends \
  apt-file \
  bash-completion \
  bluetooth \
  build-essential \
  cmake \
  curl \
  file \
  git \
  gpg-agent \
  lsb-release \
  lynx \
  man-db \
  minicom \
  pkg-config \
  plocate \
  python3-dev \
  python3-pip \
  python3-setuptools \
  python3-venv \
  python3-wheel \
  screen \
  speedtest-cli \
  time \
  tmux \
  tree \
  unzip \
  usbutils \
  vim \
  wget \
  >> $LOGFILE 2>&1

echo "Finished"
