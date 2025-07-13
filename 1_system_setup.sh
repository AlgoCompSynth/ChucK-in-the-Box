#! /usr/bin/env bash

set -e

pushd Scripts > /dev/null
  ./terminal_setup.sh
  ./pios_edit_swapfile_size.sh
  ./apt_system_upgrade.sh
  ./apt_base_packages.sh

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

  echo ""
  echo "Configuring multi-user.target"
  sudo systemctl set-default multi-user.target
popd > /dev/null

echo ""
echo "Reboot to finish upgrades"
