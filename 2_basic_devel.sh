#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/1_global_installs.log"
rm --force $LOGFILE

sudo cp locale.gen /etc/
sudo locale-gen
echo "Installing base packages"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get update \
  >> $LOGFILE 2>&1
/usr/bin/time sudo apt-get upgrade --assume-yes \
  >> $LOGFILE 2>&1
/usr/bin/time sudo apt-get install --assume-yes --no-install-recommends \
  apt-file \
  bash-completion \
  build-essential \
  cmake \
  curl \
  file \
  gettext \
  lsb-release \
  lynx \
  man-db \
  minicom \
  plocate \
  screen \
  speedtest-cli \
  tmux \
  tree \
  unzip \
  usbutils \
  wget \
  >> $LOGFILE 2>&1

echo "Finished!"
