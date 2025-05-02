#! /usr/bin/env bash

set -e

echo ""
echo "*** Audio Base Packages ***"

echo "Defining LOGFILE"
mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/apt_audio_base.log"
rm --force $LOGFILE

echo "Adding $USER to the 'audio' group"
sudo usermod -aG audio $USER

echo "Installing audio base packages"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install --assume-yes --no-install-recommends \
  alsa-utils \
  ffmpeg \
  flac \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  fluidsynth \
  freepats \
  libasound2-dev \
  libasound2-plugins \
  libcanberra-gtk3-module \
  libsndfile1-dev \
  libsox-fmt-all \
  libsoxr0 \
  mp3splt \
  pipewire-audio \
  rtkit \
  sf3convert \
  sndfile-tools \
  sox \
  timidity \
  wireplumber \
  wireplumber-doc \
  >> $LOGFILE 2>&1

echo "Finished"
