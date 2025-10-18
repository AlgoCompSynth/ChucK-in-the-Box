#! /usr/bin/env bash

set -e

mkdir --parents $HOME/.fonts
pushd $HOME/.fonts > /dev/null
  rm --force --recursive Meslo*
  echo "Donwloading 'Meslo' nerd fonts"
  curl -sOL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip
  mkdir Meslo
  cd Meslo
  unzip -qq ../Meslo.zip
  mkdir --parents $HOME/.fonts
  mv *.ttf $HOME/.fonts
  cd ..
  rm --force --recursive Meslo Meslo.zip
  echo "'Meslo' nerd fonts installed in $HOME/.fonts"
popd > /dev/null
