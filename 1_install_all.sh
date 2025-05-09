#! /usr/bin/env bash

set -e

./terminal_setup.sh
./apt_audio_base.sh
./install_sysstat.sh
./linux_dependencies.sh
./apt_pkg_db_updates.sh
./install_chuck.sh
./edit_boot_params.sh
