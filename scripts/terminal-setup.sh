#! /usr/bin/env bash

set -e

echo ""
echo "** Terminal Setup **"

echo "Creating \$HOME/.local/bin"
mkdir --parents $HOME/.local/bin

echo "Setting base configuration files"
cp ./configs/bash_aliases $HOME/.bash_aliases; source ./configs/bash_aliases
cp ./configs/vimrc $HOME/.vimrc

echo "** Finished Terminal Setup **"
