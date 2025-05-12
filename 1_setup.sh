#! /usr/bin/env bash

set -e

echo ""
echo "*** System Setup ***"

echo "Creating $HOME/.local/bin, $HOME/bin, and $HOME/Projects"
mkdir --parents $HOME/.local/bin $HOME/bin $HOME/Projects

echo "Setting base configuration files"
cp bashrc $HOME/.bashrc; source bashrc
cp bash_aliases $HOME/.bash_aliases; source bash_aliases
cp vimrc $HOME/.vimrc

echo "Downloading patched MesloLG Nerd fonts"
pushd /tmp
  rm --force --recursive Meslo*
  curl -sOL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip
  mkdir Meslo
  cd Meslo
  unzip -qq ../Meslo.zip

  echo "Copying to $HOME/.fonts"
  mkdir --parents $HOME/.fonts
  cp *.ttf $HOME/.fonts

  popd

echo "Installing Starship"
./install_starship.sh
mkdir --parents $HOME/.config
cp starship.toml $HOME/.config/starship.toml

echo "Adding Starship prompt to bash"
echo 'eval "$(starship init bash)"' >> $HOME/.bashrc

./edit_swapfile_size.sh
./install_sysstat.sh

echo ""
echo "Restart bash to get new Starship prompt"

echo "Finished"
