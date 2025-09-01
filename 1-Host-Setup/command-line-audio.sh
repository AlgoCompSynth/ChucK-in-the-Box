#! /usr/bin/env bash

set -e

echo ""
echo "*** Command Line Audio ***"

echo "Setting base configuration files"
cp bash_aliases $HOME/.bash_aliases; source bash_aliases
cp vimrc $HOME/.vimrc

echo "Installing Linux packages" | tee --append $LOGFILE
sudo apt-get update -qq \
  >> $LOGFILE 2>&1
sudo apt-get install -qqy --no-install-recommends \
  alsa-utils \
  apt-file \
  bash-completion \
  build-essential \
  byobu \
  ca-certificates \
  cmake \
  curl \
  file \
  flac \
  git \
  lsb-release \
  lynx \
  mp3splt \
  pipewire-alsa \
  pipewire-bin \
  pipewire-doc \
  pkg-config \
  plocate \
  pmidi \
  rtkit \
  sox \
  time \
  tree \
  unzip \
  usbutils \
  vim \
  wget \
  >> $LOGFILE 2>&1

echo "Updating apt-file database"
sudo apt-file update \
  >> $LOGFILE 2>&1

echo "Installing Starship for user"
# https://starship.rs/guide/#%F0%9F%9A%80-installation
pushd /tmp > /dev/null
  export BIN_DIR=$LOCALBIN
  rm --force install.sh
  curl --silent --show-error --remote-name https://starship.rs/install.sh
  chmod +x install.sh
  ./install.sh --yes \
    >> $LOGFILE 2>&1
popd > /dev/null
mkdir --parents $HOME/.config
cp starship.toml $HOME/.config/starship.toml
echo 'eval "$(starship init bash)"' >> $HOME/.bashrc

echo "Updating locate database"
sudo updatedb \
  >> $LOGFILE 2>&1

echo "*** Finished Command Line Audio ***" | tee --append $LOGFILE
echo ""
