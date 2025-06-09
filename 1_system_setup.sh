#! /usr/bin/env bash

set -e

./terminal_setup.sh
./pios_edit_swapfile_size.sh
./apt_system_upgrade.sh
./apt_command_line_tools.sh
./apt_install_sysstat.sh

echo ""
echo "Reboot to finish upgrades"

echo "Finished"
