#! /usr/bin/env bash

set -e
set -v

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
sudo apt-get install --assume-yes \
  apt-file \
  bash-completion \
  bluetooth \
  build-essential \
  byobu \
  ca-certificates \
  cmake \
  chuck \
  curl \
  faust* \
  file \
  fluidsynth \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  git \
  libfluidsynth-dev \
  lynx \
  opl3-soundfont \
  pipewire-doc \
  pipewire-jack \
  pkg-config \
  plocate \
  podman \
  polyphone \
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
  wireplumber-doc \
  >> $LOGFILE 2>&1

dpkg-query --list > dpkg-query-list.log 2>&1
pw-jack chuck --version 2> chuck-probe.log
pw-jack chuck --probe >> chuck-probe.log 2>&1
faust --version > faust-version.log 2>&1

echo "** Finished Apt Packages **" | tee --append $LOGFILE
echo ""
