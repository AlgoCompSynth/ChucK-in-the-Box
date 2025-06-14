#! /usr/bin/env bash

set -e

pushd Scripts > /dev/null
  ./terminal_setup.sh
  ./pios_edit_swapfile_size.sh
  ./apt_system_upgrade.sh
  ./apt_command_line_tools.sh
  ./apt_install_sysstat.sh
  ./apt_check_for_desktop.sh
popd > /dev/null

echo ""
echo "Reboot to finish upgrades"

echo "Finished"
