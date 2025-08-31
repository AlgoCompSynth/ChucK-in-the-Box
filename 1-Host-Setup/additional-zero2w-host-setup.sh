#! /usr/bin/env bash

set -e

echo ""
echo "*** Zero 2 W Host Setup ***"

source ../set_envars.sh
export LOGFILE=$LOGFILES/additional-zero2w-host-setup.log
rm --force $LOGFILE

echo "Editing swapfile size"
# https://pimylifeup.com/raspberry-pi-swap-file/
sudo dphys-swapfile swapoff
sleep 5
diff dphys-swapfile /etc/dphys-swapfile || true
sudo cp dphys-swapfile /etc/dphys-swapfile
sudo dphys-swapfile setup
sudo dphys-swapfile swapon

echo ""
echo "Patching cmdline.txt"
sleep 10
# https://learn.adafruit.com/turning-your-raspberry-pi-zero-into-a-usb-gadget/ethernet-gadget
cp /boot/firmware/cmdline.txt .
sudo sed -i \
  's/rootwait/rootwait modules-load=dwc2,g_audio modules-load=dwc2,g_midi/' \
  /boot/firmware/cmdline.txt
diff cmdline.txt /boot/firmware/cmdline.txt || true

echo ""
echo "Patching config.txt"
sleep 10
cp /boot/firmware/config.txt .
sudo sed -i '$ a dtoverlay=dwc2' /boot/firmware/config.txt
diff config.txt /boot/firmware/config.txt || true

echo "*** Finished Zero 2 W Host Setup ***" | tee --append $LOGFILE
