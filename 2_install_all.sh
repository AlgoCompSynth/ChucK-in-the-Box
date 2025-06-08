#! /usr/bin/env bash

set -e

./apt_audio_base.sh
./apt_linux_dependencies.sh
./install_chuck.sh
./apt_pkg_db_updates.sh
