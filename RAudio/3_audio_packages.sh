#! /usr/bin/env bash

set -e

echo ""
echo "*** Audio Packages ***"

export LOGFILE=$PWD/Logs/audio_packages.log
rm --force $LOGFILE

echo "Installing Linux dependencies"
export DEBIAN_FRONTEND=noninteractive
/usr/bin/time sudo apt-get install --yes \
  cmake \
  flac \
  ffmpeg \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  freepats \
  libavfilter-dev \
  libcurl4-openssl-dev \
  libfftw3-dev \
  libfftw3-doc \
  libfluidsynth-dev \
  libmagick++-dev \
  libsox-dev \
  libsox-fmt-all  \
  libsoxr-dev  \
  mp3splt \
  sox \
  >> $LOGFILE 2>&1

echo "Installing R audio packages - this takes some time."
/usr/bin/time ./audio_packages.R \
  >> $LOGFILE 2>&1

echo "Finished"
