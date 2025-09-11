#! /usr/bin/env bash

set -e

echo ""
echo "* PiOS Standard Setup *"

source ./set_envars.sh
export LOGFILE=$LOGFILES/pios-standard-setup.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo "Installing Linux base tools"
sudo apt-get update -qq \
  >> $LOGFILE 2>&1
sudo apt-get install -qqy --no-install-recommends \
  apt-file \
  bash-completion \
  bison \
  bluetooth \
  build-essential \
  ca-certificates \
  cmake \
  curl \
  file \
  flex \
  git \
  libasound2-dev \
  libcanberra-gtk3-module \
  libpulse-dev \
  libqscintilla2-qt6-dev \
  libsndfile1-dev \
  lsb-release \
  lynx \
  pipewire-alsa \
  pipewire-doc \
  pipewire-pulse \
  pkg-config \
  plocate \
  qt6-base-dev \
  qt6-base-dev-tools \
  qt6-wayland \
  time \
  tree \
  unzip \
  usbutils \
  vim \
  wget \
  wireplumber-doc \
  >> $LOGFILE 2>&1

# https://wiki.debian.org/BluetoothUser
echo "Reconfiguring Bluetooth" | tee --append $LOGFILE
sudo service bluetooth stop
diff bluetooth-main.conf /etc/bluetooth/main.conf || true
sudo cp bluetooth-main.conf /etc/bluetooth/main.conf
sudo service bluetooth start

if [[ "$BLOKAS_PISOUND" == "1" ]]
then
  echo "Installing Blokas Pisound software"
  curl --silent https://blokas.io/pisound/install.sh | sh \
    >> $LOGFILE 2>&1

fi

echo "Updating apt-file database"
sudo apt-file update \
  >> $LOGFILE 2>&1

echo "Updating locate database"
sudo updatedb \
  >> $LOGFILE 2>&1

echo "* Finished PiOS Standard Setup *" | tee --append $LOGFILE
