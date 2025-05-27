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

# https://tecadmin.net/how-to-add-swap-in-ubuntu-24-04/

if [ ! -f /swapfile ]
then
  echo "Allocating 1 GB swapfile"
  sudo fallocate -l 1G /swapfile
  sudo chmod 600 /swapfile
  sudo mkswap /swapfile

  echo "Enabling swap"
  sudo swapon /swapfile
  sudo swapon --show

  echo "Adding swap to fstab"
  cp /etc/fstab .
  sudo sed -i "$ a /swapfile none swap sw 0 0" /etc/fstab
  diff fstab /etc/fstab || true
fi

echo "Upgrading system"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update \
  >> $LOGFILE 2>&1
sudo apt-get full-upgrade --assume-yes \
  >> $LOGFILE 2>&1
sudo apt-get autoremove --assume-yes \
  >> $LOGFILE 2>&1

echo "Installing unzip"
sudo apt-get install --assume-yes --no-install-recommends \
  unzip \
  >> $LOGFILE 2>&1

echo "Downloading patched MesloLG Nerd fonts"
mkdir --parents $HOME/.fonts
pushd $HOME/.fonts
  rm --force Meslo.zip
  curl -sOL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip
  unzip -o Meslo.zip \
    >> $LOGFILE 2>&1
  rm --force Meslo.zip
popd

echo "Installing Starship"
./install_starship.sh
mkdir --parents $HOME/.config
cp starship.toml $HOME/.config/starship.toml

echo "Adding Starship prompt to bash"
echo 'eval "$(starship init bash)"' >> $HOME/.bashrc

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
