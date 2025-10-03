#! /usr/bin/env bash

set -e

mkdir --parents $HOME/.config
cp configs/starship.toml $HOME/.config/starship.toml
echo 'eval "$(starship init bash)"' >> $HOME/.bashrc
