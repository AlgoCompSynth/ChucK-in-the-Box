#! /usr/bin/env bash

set -e

echo ""
echo "*** System Setup ***"

mkdir --parents "$PWD/Logs"
export LOGFILE="$PWD/Logs/system_setup.log"
rm --force $LOGFILE

echo "Creating $HOME/.local/bin, $HOME/bin, and $HOME/Projects"
mkdir --parents $HOME/.local/bin $HOME/bin $HOME/Projects

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

  echo "Copying to $HOME/.fonts"
  mkdir --parents $HOME/.fonts
  cp *.ttf $HOME/.fonts

popd > /dev/null

echo "Installing Starship"
./install_starship.sh
mkdir --parents $HOME/.config
cp starship.toml $HOME/.config/starship.toml

echo "Adding Starship prompt to bash"
echo 'eval "$(starship init bash)"' >> $HOME/.bashrc

./pios_edit_swapfile_size.sh

echo "Defining locales"
sudo cp locale.gen /etc/
sudo locale-gen

echo "Upgrading system"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update \
  >> $LOGFILE 2>&1
sudo apt-get full-upgrade --assume-yes \
  >> $LOGFILE 2>&1
sudo apt-get autoremove --assume-yes \
  >> $LOGFILE 2>&1

./apt_command_line_tools.sh
./apt_install_sysstat.sh

echo ""
echo "Reboot to finish upgrades"

echo "Finished"
