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
/usr/bin/time sudo apt-get install --assume-yes --no-install-recommends \
  alsa-utils \
  apt-file \
  bash-completion \
  build-essential \
  cmake \
  curl \
  file \
  lsb-release \
  lynx \
  man-db \
  minicom \
  ninja-build \
  pipewire-alsa \
  pipewire-audio \
  pipewire-doc \
  pipewire-jack \
  pipewire-pulse \
  pkg-config \
  plocate \
  pulseaudio-utils \
  python3-dev \
  python3-pip \
  python3-setuptools \
  python3-venv \
  python3-wheel \
  rtkit \
  screen \
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
