#! /usr/bin/env bash

set -e

echo ""
echo "* PiOS UAC2 Gadget *"

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

echo "* Finished PiOS UAC2 Gadget *"
