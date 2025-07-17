#! /usr/bin/env bash

set -e

echo ""
echo "*** Terminal Setup ***"

echo "Creating \$HOME/Projects, \$HOME/.local/bin, and \$HOME/bin"
mkdir --parents $HOME/Projects
mkdir --parents $HOME/.local/bin
mkdir --parents $HOME/bin

echo "Setting base configuration files"
cp bashrc $HOME/.bashrc; source bashrc
cp bash_aliases $HOME/.bash_aliases; source bash_aliases
cp vimrc $HOME/.vimrc

echo "Downloading patched MesloLG Nerd fonts"
pushd /tmp > /dev/null
  rm --force --recursive Meslo*
  curl -sOL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip
  mkdir Meslo
  cd Meslo
  unzip -qq ../Meslo.zip

  echo "Copying to HOME/.fonts"
  mkdir --parents $HOME/.fonts
  cp *.ttf $HOME/.fonts
popd > /dev/null

echo "Installing Starship"
./install_starship.sh

echo "Adding Starship prompt to bash"
echo 'eval "$(starship init bash)"' >> $HOME/.bashrc

echo "*** Finished Terminal Setup ***"
