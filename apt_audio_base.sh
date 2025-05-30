#! /usr/bin/env bash

set -e

echo ""
echo "*** Audio Base Packages ***"

echo "Defining LOGFILE"
mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/audio_base.log"
rm --force $LOGFILE

echo "Installing audio base packages"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get install --assume-yes --no-install-recommends \
  alsa-utils \
  apt-file \
  bash-completion \
  build-essential \
  cmake \
  curl \
  file \
  flac \
  libsox-fmt-all \
  libsox3 \
  libsoxr0 \
  lsb-release \
  lynx \
  man-db \
  minicom \
  mp3splt \
  ninja-build \
  pipewire-alsa \
  pkg-config \
  plocate \
  pmidi \
  python3-dev \
  python3-pip \
  python3-setuptools \
  python3-venv \
  python3-wheel \
  rtkit \
  screen \
  sox \
  speedtest-cli \
  tmux \
  tree \
  unzip \
  usbutils \
  wget \
  wireplumber \
  wireplumber-doc \
  >> $LOGFILE 2>&1

echo "Finished"
