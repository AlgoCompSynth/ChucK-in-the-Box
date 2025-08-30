#! /usr/bin/env bash

set -e

echo ""
echo "*** Container Setup ***"

source ../set_envars.sh
echo "Creating $PROJECTS $LOGFILES $LOCALBIN"
mkdir --parents $PROJECTS $LOGFILES $LOCALBIN
export LOGFILE=$LOGFILES/container-setup.log
rm --force $LOGFILE

echo "Setting base configuration files"
cp bash_aliases $HOME/.bash_aliases; source bash_aliases
cp vimrc $HOME/.vimrc

echo "Upgrading container"
sudo apt-get update \
  >> $LOGFILE 2>&1
# https://debian-handbook.info/browse/stable/sect.automatic-upgrades.html
yes '' \
  | sudo apt-get -y \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" \
  dist-upgrade \
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

echo "*** Finished Container Setup ***" | tee --append $LOGFILE
