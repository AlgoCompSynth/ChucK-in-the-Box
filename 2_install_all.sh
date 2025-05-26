#! /usr/bin/env bash

set -e

./apt_audio_base.sh
./linux_dependencies.sh
./apt_pkg_db_updates.sh
./install_opencl.sh
./install_chuck.sh
