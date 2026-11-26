#! /usr/bin/env bash

set -eu

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
  bison \
  bluez-alsa-utils \
  build-essential \
  cmake \
  curl \
  file \
  flac \
  flex \
  git \
  libasound2-dev \
  libsndfile1-dev \
  libssl-dev \
  libsox-fmt-all \
  luajit \
  lynx \
  mp3splt \
  neovim \
  pkgconf \
  plocate \
  pmidi \
  ripgrep \
  rtkit \
  sox \
  starship \
  time \
  tree \
  tmux \
  unzip \
  upower \
  usbutils \
  wget \
  zlib1g-dev \
  >> $LOGFILE 2>&1

echo "Enabling / starting rtkit"
sudo systemctl enable --now rtkit-daemon.service

echo "** Finished Command Line Packages **"
