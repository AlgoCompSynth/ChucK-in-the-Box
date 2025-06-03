#! /usr/bin/env bash

set -e

echo ""
echo "*** System Setup ***"

echo "Defining LOGFILE"
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

./edit_swapfile_size.sh

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

echo "Installing git, sysstat, time, and vim"
sudo apt-get install --assume-yes --no-install-recommends \
  git \
  sysstat \
  time \
  vim \
  >> $LOGFILE 2>&1

echo "Enabling sysstat"
# https://wiki.debian.org/sysstat
sudo systemctl enable --now sysstat.service
systemctl status sysstat.service

echo "Stopping data collections"
sudo systemctl stop sysstat

echo "Editing sample time"
diff sysstat-collect.timer /etc/systemd/system/sysstat.service.wants/sysstat-collect.timer || true
sudo cp sysstat-collect.timer /etc/systemd/system/sysstat.service.wants/sysstat-collect.timer

sleep 5
echo ""
echo "Restarting data collection"
sudo systemctl daemon-reload
sudo systemctl restart sysstat

echo ""
echo "Restart bash to get new Starship prompt"

echo "Finished"
