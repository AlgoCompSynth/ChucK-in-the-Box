#! /usr/bin/env bash

set -e

echo ""
echo "* Zero 2 W Host Setup *"

source ../set_envars.sh
mkdir --parents $LOGFILES
export LOGFILE=$LOGFILES/zero2w-host-setup.log
rm --force $LOGFILE

echo "Editing swapfile size"
# https://pimylifeup.com/raspberry-pi-swap-file/
sudo dphys-swapfile swapoff
sleep 5
diff dphys-swapfile /etc/dphys-swapfile || true
sudo cp dphys-swapfile /etc/dphys-swapfile
sudo dphys-swapfile setup
sudo dphys-swapfile swapon

# https://github.com/mdsimon2/RPi-CamillaDSP?tab=readme-ov-file#8-enable-usb-gadget-optional
echo ""
echo "Patching config.txt"
sleep 10
cp /boot/firmware/config.txt .
echo 'dtoverlay=dwc2' \
  | sudo tee --append /boot/firmware/config.txt \
  > /dev/null
diff config.txt /boot/firmware/config.txt || true

echo "Patching /etc/modules"
sleep 10
cp /etc/modules .
echo -e 'dwc2\ng_audio' \
  | sudo tee --append /etc/modules \
  > /dev/null
diff modules /etc/modules || true

echo "Setting g_audio parameters"
sleep 10
sudo cp g_audio.conf /etc/modprobe.d/g_audio.conf

echo "Reboot to enable USB audio gadget"

echo "* Finished Zero 2 W Host Setup *" | tee --append $LOGFILE
