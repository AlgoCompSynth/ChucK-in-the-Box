#! /usr/bin/env bash

set -e

mkdir --parents $HOME/.fonts
pushd $HOME/.fonts > /dev/null
  rm --force --recursive Meslo*
  curl -sOL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip
  mkdir Meslo
  cd Meslo
  unzip -qq ../Meslo.zip
  mv *.ttf $HOME/.fonts
  cd ..
  rm -fr Meslo.zip Meslo
popd > /dev/null
