#! /usr/bin/env bash

set -e

echo ""
echo "*** PiOS Host Setup ***"

source ../set_envars.sh
echo "Creating $PROJECTS $LOGFILES $LOCALBIN"
mkdir --parents $PROJECTS $LOGFILES $LOCALBIN
export LOGFILE=$LOGFILES/pios-host-setup.log
rm --force $LOGFILE

echo "Setting base configuration files"
cp bash_aliases $HOME/.bash_aliases; source bash_aliases
cp vimrc $HOME/.vimrc

if [[ "$(uname --kernel-release)" =~ "rpt-rpi-v8" ]]
then
  echo "Upgrading system"
  sudo apt-get update \
    >> $LOGFILE 2>&1
  # https://debian-handbook.info/browse/stable/sect.automatic-upgrades.html
  yes '' \
    | sudo apt-get -y \
    -o Dpkg::Options::="--force-confdef" \
    -o Dpkg::Options::="--force-confold" \
    dist-upgrade \
    >> $LOGFILE 2>&1
  
  echo "Installing utilities" | tee --append $LOGFILE
  sudo apt-get install --assume-yes \
    apt-file \
    bash-completion \
    bluetooth \
    build-essential \
    cmake \
    curl \
    file \
    git \
    lsb-release \
    lynx \
    man-db \
    minicom \
    pkg-config \
    plocate \
    podman \
    qpwgraph \
    screen \
    speedtest-cli \
    tilix \
    time \
    tmux \
    tree \
    uidmap \
    unzip \
    usbutils \
    vim \
    wget \
    >> $LOGFILE 2>&1

  echo "Reconfiguring Bluetooth"
  # https://wiki.debian.org/BluetoothUser
  sudo service bluetooth stop
  diff main.conf /etc/bluetooth/main.conf || true
  sudo cp main.conf /etc/bluetooth/main.conf
  sudo service bluetooth start

  ../apt_pkg_db_updates.sh

fi

echo "Installing Distrobox globally"
pushd $PROJECTS > /dev/null
  rm -fr distrobox
  git clone https://github.com/89luca89/distrobox.git \
    >> $LOGFILE 2>&1
  cd distrobox
  sudo ./install \
    >> $LOGFILE 2>&1
popd > /dev/null

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

echo "Installing 'nerd fonts' for user"
mkdir --parents $HOME/.fonts
pushd $HOME/.fonts > /dev/null
  rm --force Meslo.zip
  curl -sOL \
    https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip
  unzip -qqo Meslo.zip
  rm --force Meslo.zip LICENSE.txt README.md
popd > /dev/null

echo "*** Finished PiOS Host Setup ***" | tee --append $LOGFILE
