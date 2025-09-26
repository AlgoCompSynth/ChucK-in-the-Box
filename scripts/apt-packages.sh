#! /usr/bin/env bash

set -e

echo ""
echo "** Apt Packages **"

source ./set_envars.sh
export LOGFILE=$LOGFILES/apt-packages.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -qqy --no-install-recommends \
  apt-file \
  bash-completion \
  byobu \
  curl \
  file \
  git \
  libspa-0.2-bluetooth \
  lynx \
  pipewire \
  pipewire-doc \
  pipewire-pulse \
  plocate \
  podman \
  pulseaudio \
  rtkit \
  time \
  tree \
  uidmap \
  unzip \
  usbutils \
  vim \
  wget \
  wireplumber \
  wireplumber-doc \
  >> $LOGFILE 2>&1

if [[ "$GRAPHICAL_TARGET" == "1" ]]
then
  sudo apt-get install -qqy --no-install-recommends \
    fluid-soundfont-gm \
    fluid-soundfont-gs \
    fluidsynth \
    opl3-soundfont \
    polyphone \
    >> $LOGFILE 2>&1

fi

dpkg-query --list > dpkg-query-list.log

echo "** Finished Apt Packages **" | tee --append $LOGFILE
