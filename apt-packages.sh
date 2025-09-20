#! /usr/bin/env bash

set -e

echo ""
echo "** Apt Packages **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/apt-packages.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo "Upgrading system" | tee --append $LOGFILE
# https://debian-handbook.info/browse/stable/sect.automatic-upgrades.html
export DEBIAN_FRONTEND=noninteractive
sudo cp bookworm-backports.list /etc/apt/sources.list.d/
sudo apt-get update -qq \
  >> $LOGFILE 2>&1
yes '' | sudo apt-get -qqy \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  full-upgrade \
  >> $LOGFILE 2>&1
echo "Installing Linux packages" | tee --append $LOGFILE
sudo apt-get install -qqy --no-install-recommends \
  alsa-utils \
  apt-file \
  bash-completion \
  bluetooth \
  build-essential \
  byobu \
  ca-certificates \
  cmake \
  curl \
  file \
  git \
  lynx \
  pipewire \
  pipewire-doc \
  pipewire-pulse \
  pkg-config \
  plocate \
  podman \
  pulseaudio \
  screen \
  speedtest-cli \
  time \
  tmux \
  tree \
  uidmap \
  unzip \
  usbutils \
  vim \
  wget \
  wireplumber \
  wireplumber-doc \
  >> $LOGFILE 2>&1

dpkg-query --list 2>&1 | tee dpkg-query-list.log

echo "** Finished Apt Packages **" | tee --append $LOGFILE
echo ""
