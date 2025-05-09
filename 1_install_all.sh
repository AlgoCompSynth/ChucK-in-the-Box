#! /usr/bin/env bash

set -e

./terminal_setup.sh
./apt_audio_base.sh
./linux_dependencies.sh
./apt_pkg_db_updates.sh
./install_chuck.sh
