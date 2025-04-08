#! /usr/bin/env bash

set -e

echo "Editing swapfile size"
# https://pimylifeup.com/raspberry-pi-swap-file/
sudo dphys-swapfile swapoff
sleep 5
diff dphys-swapfile /etc/dphys-swapfile || true
sudo cp dphys-swapfile /etc/dphys-swapfile
sudo dphys-swapfile setup
sudo dphys-swapfile swapon

sleep 5
echo ""
echo "Patching cmdline.txt"
# https://learn.adafruit.com/turning-your-raspberry-pi-zero-into-a-usb-gadget/ethernet-gadget
cp /boot/firmware/cmdline.txt .
sudo sed -i \
  's/rootwait/rootwait modules-load=dwc2,g_audio modules-load=dwc2,g_midi/' \
  /boot/firmware/cmdline.txt
diff cmdline.txt /boot/firmware/cmdline.txt || true

sleep 5
echo ""
echo "Patching config.txt"
cp /boot/firmware/config.txt .
sudo sed -i '$ a dtoverlay=dwc2' /boot/firmware/config.txt
diff config.txt /boot/firmware/config.txt || true

sleep 5
echo ""
echo "Defining LOGFILE"
mkdir --parents $PWD/Logs
export LOGFILE=$PWD/Logs/linux_packages.log
rm --force $LOGFILE

echo "Adding $USER to the 'audio' group"
sudo usermod -aG audio $USER

sudo cp locale.gen /etc/
sudo locale-gen

echo "Installing Linux packages"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update \
  >> $LOGFILE 2>&1
sudo apt-get upgrade -y \
  >> $LOGFILE 2>&1
sudo apt-get autoremove -y \
  >> $LOGFILE 2>&1
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
  libsamplerate0-dev \
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

sleep 5
echo ""
echo "Disk space"
df -h

echo "Finished -- reboot!"
