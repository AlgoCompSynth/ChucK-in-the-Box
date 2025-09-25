#! /usr/bin/env bash

set -e

echo ""
echo "** Apt Packages **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/apt-packages.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
  #alsa-utils \
  #bluetooth \
  #bluez-alsa-utils \
  #build-essential \
  #ca-certificates \
  #cmake \
  #lynx \
  #pipewire \
  #pipewire-doc \
  #pipewire-pulse \
  #pkg-config \
  #pulseaudio \
  #pulseaudio-module-bluetooth \
  #pulseaudio-utils \
  #screen \
  #speedtest-cli \
  #tmux \
  #wireplumber \
  #wireplumber-doc \
sudo apt-get install -qqy --no-install-recommends \
  apt-file \
  bash-completion \
  byobu \
  curl \
  file \
  git \
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

dpkg-query --list > dpkg-query-list.log

echo "** Finished Apt Packages **" | tee --append $LOGFILE
echo ""
