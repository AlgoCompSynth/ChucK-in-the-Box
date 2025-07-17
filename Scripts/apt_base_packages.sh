#! /usr/bin/env bash

set -e

echo ""
echo "*** Base Packages ***"

mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/base_packages.log"
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
echo "Installing packages"
sudo apt-get install --assume-yes --no-install-recommends \
  apt-file \
  bash-completion \
  bluetooth \
  build-essential \
  cmake \
  curl \
  file \
  git \
  lsb-release \
  lynx \
  man-db \
  minicom \
  pkg-config \
  plocate \
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

echo "Reconfiguring Bluetooth"
# https://wiki.debian.org/BluetoothUser
sudo service bluetooth stop
diff main.conf /etc/bluetooth/main.conf || true
sudo cp main.conf /etc/bluetooth/main.conf
sudo service bluetooth start

echo "*** Finished Base Packages ***"
