#! /usr/bin/env bash

set -e

# https://rustup.rs/
pushd /tmp > /dev/null
  rm --force install-rustup.sh
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > install-rustup.sh
  chmod +x install-rustup.sh
  ./install-rustup.sh -y
  . "$HOME/.cargo/env"            # For sh/bash/zsh/ash/dash/pdksh
  echo $PATH
popd > /dev/null
