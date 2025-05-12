#! /usr/bin/env bash

set -e

echo ""
echo "*** Audio Base Packages ***"

echo "Defining LOGFILE"
mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/audio_base.log"
rm --force $LOGFILE

echo "Defining locales"
sudo cp locale.gen /etc/
sudo locale-gen

echo "Upgrading system"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update \
  >> $LOGFILE 2>&1
sudo apt-get upgrade --assume-yes \
  >> $LOGFILE 2>&1
sudo apt-get autoremove --assume-yes \
  >> $LOGFILE 2>&1

echo "Installing audio base packages"
sudo apt-get install --assume-yes --no-install-recommends \
  alsa-utils \
  apt-file \
  bash-completion \
  build-essential \
  cmake \
  curl \
  file \
  flac \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  fluidsynth \
  freepats \
  libsox-fmt-all  \
  lsb-release \
  lynx \
  man-db \
  minicom \
  mp3splt \
  ninja-build \
  pipewire-alsa \
  pipewire-doc \
  pkg-config \
  plocate \
  python3-dev \
  python3-pip \
  python3-setuptools \
  python3-venv \
  python3-wheel \
  rtkit \
  screen \
  sox \
  speedtest-cli \
  time \
  tmux \
  tree \
  unzip \
  usbutils \
  vim \
  wget \
  wireplumber \
  wireplumber-doc \
  >> $LOGFILE 2>&1

echo "Finished"
