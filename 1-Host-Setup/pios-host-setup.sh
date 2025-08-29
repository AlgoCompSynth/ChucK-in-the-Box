#! /usr/bin/env bash

set -e

echo ""
echo "*** PiOS Host Setup ***"

source ../set_envars.sh
echo "Creating $PROJECTS $LOGFILES $LOCALBIN"
mkdir --parents $PROJECTS $LOGFILES $LOCALBIN
export LOGFILE=$LOGFILES/desktop-setup.log
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
    file \
    git \
    lsb-release \
    plocate \
    podman \
    qpwgraph \
    tilix \
    time \
    tree \
    uidmap \
    vim \
    >> $LOGFILE 2>&1

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
