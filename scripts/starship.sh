#! /usr/bin/env bash

set -e

# https://starship.rs/guide/#%F0%9F%9A%80-installation
pushd /tmp > /dev/null
  export BIN_DIR=$HOME/.local/bin
  mkdir --parents $BIN_DIR
  rm --force install.sh
  echo "Downloading 'starship' installer"
  curl --silent --show-error --remote-name https://starship.rs/install.sh
  chmod +x install.sh
  echo "Running 'starship' installer"
  ./install.sh --yes > /dev/null
popd > /dev/null
echo "Configuring 'starship'"
mkdir --parents $HOME/.config
cp ./configs/starship.toml $HOME/.config

echo "Appending Starship init to \$HOME/.bashrc"
echo 'eval "$(starship init bash)"' >> $HOME/.bashrc
