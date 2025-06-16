#! /usr/bin/env bash

set -e

pushd Scripts > /dev/null
  ./pios_edit_swapfile_size.sh
  ./apt_system_upgrade.sh
  ./apt_base_packages.sh
  ./terminal_setup.sh
  ./apt_install_sysstat.sh

  echo ""
  echo ""
  source ram_kbytes.sh
  if [[ "$RAM_KBYTES" -lt "3500000" ]]
  then
    echo "Insufficient RAM for GUI apps"
    sudo systemctl set-default multi-user.target
  else
    echo "Enabling GUI apps"
    ./apt_install_xpra.sh
    sudo systemctl set-default graphical.target
  fi

popd > /dev/null

echo ""
echo "Reboot to finish upgrades"
echo "Finished"
