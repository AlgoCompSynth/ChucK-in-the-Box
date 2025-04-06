#! /usr/bin/env bash

set -e

echo "Edit swapfile size"
# https://pimylifeup.com/raspberry-pi-swap-file/
sudo dphys-swapfile swapoff
sleep 5
diff dphys-swapfile /etc/dphys-swapfile || true
sudo cp dphys-swapfile /etc/dphys-swapfile
sudo dphys-swapfile setup
sudo dphys-swapfile swapon

# https://learn.adafruit.com/turning-your-raspberry-pi-zero-into-a-usb-gadget/ethernet-gadget
echo "Patching cmdline.txt"
cp /boot/firmware/cmdline.txt .
sudo sed -i \
  's/rootwait/rootwait modules-load=dwc2,g_audio modules-load=dwc2,g_midi/' \
  /boot/firmware/cmdline.txt
diff cmdline.txt /boot/firmware/cmdline.txt || true

echo "Patching config.txt"
cp /boot/firmware/config.txt .
sudo sed -i '$ a dtoverlay=dwc2' /boot/firmware/config.txt
diff config.txt /boot/firmware/config.txt || true

export DEBIAN_FRONTEND=noninteractive

echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/linux_packages.log
rm --force $LOGFILE

echo "Adding $USER to the 'audio' group"
sudo usermod -aG audio $USER

echo "Setting locale"
sudo cp locale.gen /etc/
sudo locale-gen

echo "Installing Linux packages"
sudo apt-get update
sudo apt-get upgrade -qqy
sudo apt-get autoremove -qqy
time sudo apt-get install -y \
  alsa-utils \
  apt-file \
  bash-completion \
  bison \
  build-essential \
  curl \
  file \
  flex \
  fluid-soundfont-gm \
  fluid-soundfont-gs \
  freepats \
  gdb \
  libasound2-dev \
  libasound2-doc \
  libfftw3-bin \
  libfftw3-dev \
  libsndfile1-dev \
  libsox-dev \
  libsox-fmt-all \
  libsoxr-dev \
  lsb-release \
  lynx \
  man-db \
  minicom \
  net-tools \
  plocate \
  pmidi \
  screen \
  sox \
  speedtest-cli \
  sysstat \
  time \
  timidity \
  timidity-daemon \
  tmux \
  tree \
  unzip \
  usbutils \
  vim \
  wget \
  >> $LOGFILE 2>&1

# https://wiki.debian.org/sysstat
echo "Enabling sysstat"
sudo systemctl enable --now sysstat.service
systemctl status sysstat.service

echo "Stopping data collections"
sudo systemctl stop sysstat

echo "Editing sample time"
sleep 5
diff sysstat-collect.timer /etc/systemd/system/sysstat.service.wants/sysstat-collect.timer || true
sudo cp sysstat-collect.timer /etc/systemd/system/sysstat.service.wants/sysstat-collect.timer

echo "Restarting data collection"
sudo systemctl daemon-reload
sudo systemctl restart sysstat

echo "Disk space"
df -h
lsb_release --all || true

echo "Finished -- reboot!"
