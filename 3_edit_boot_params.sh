#! /usr/bin/env bash

set -e

echo ""
echo "*** Edit boot parameters ***"

pushd Scripts > /dev/null
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

  echo "Dropping to multi-user.target"
  sudo systemctl set-default multi-user.target
popd > /dev/null

echo "Finished -- reboot!"
