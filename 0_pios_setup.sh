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

echo "Finished -- reboot!"
