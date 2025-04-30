#! /usr/bin/env bash

set -e

echo "Defining LOGFILE"
mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/audio_base.log"
rm --force $LOGFILE

echo "Installing basic development packages"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install --assume-yes --no-install-recommends \
  alsa-utils \
  apt-file \
  audacity \
  bash-completion \
  bison \
  bluez-alsa-utils \
  build-essential \
  cmake \
  curl \
  ffmpeg \
  file \
  flac \
  flex \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  fluidsynth \
  freepats \
  gettext \
  libasound2-dev \
  libasound2-plugins \
  libcanberra-gtk3-module \
  libsndfile1-dev \
  libsox-fmt-all \
  libsoxr0 \
  libtool \
  libusb-1.0-0-dev \
  lsb-release \
  lynx \
  man-db \
  minicom \
  mp3splt \
  ninja-build \
  pipewire-audio \
  pkg-config \
  plocate \
  python3-dev \
  python3-pip \
  python3-setuptools \
  python3-venv \
  python3-wheel \
  rtkit \
  screen \
  sf3convert \
  sndfile-tools \
  sox \
  speedtest-cli \
  timidity \
  tmux \
  tree \
  unzip \
  usbutils \
  wget \
  wireplumber \
  wireplumber-doc \
  >> $LOGFILE 2>&1

echo "Finished!"
