#! /usr/bin/env bash

set -e

# https://starship.rs/guide/#%F0%9F%9A%80-installation
pushd /tmp > /dev/null
  export BIN_DIR=/usr/local/bin
  sudo mkdir --parents $BIN_DIR
  rm --force install.sh
  curl --silent --show-error --remote-name https://starship.rs/install.sh
  chmod +x install.sh
  sudo ./install.sh --yes > /dev/null
popd > /dev/null

mkdir --parents $HOME/.config
cp configs/starship.toml $HOME/.config/starship.toml
echo 'eval "$(starship init bash)"' >> $HOME/.bashrc
