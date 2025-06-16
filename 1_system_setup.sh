#! /usr/bin/env bash

set -e

pushd Scripts > /dev/null
  ./pios_edit_swapfile_size.sh
  ./apt_system_upgrade.sh
  ./apt_base_packages.sh
  ./terminal_setup.sh
  ./apt_install_xpra.sh
  ./apt_install_sysstat.sh
popd > /dev/null

  echo "Switching to graphical.target"
  sudo systemctl set-default graphical.target

echo ""
echo "Reboot to finish upgrades"

echo "Finished"
