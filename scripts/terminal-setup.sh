#! /usr/bin/env bash

set -eu

echo ""
echo "** Terminal Setup **"

echo "Creating \$HOME/.local/bin"
mkdir --parents $HOME/.local/bin

echo "Setting base configuration files"
mkdir --parents $HOME/.config
cp -rp configs/dot-config/* $HOME/.config/
cp ./configs/bash_aliases $HOME/.bash_aliases; source ./configs/bash_aliases
cp ./configs/tmux.conf $HOME/.tmux.conf

echo "Setting starship activation"
echo 'eval "$(starship init bash)"' >> $HOME/.bashrc

echo "** Finished Terminal Setup **"
