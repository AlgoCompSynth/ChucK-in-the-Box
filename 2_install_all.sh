#! /usr/bin/env bash

set -e

pushd Scripts > /dev/null
  ./apt_audio_base.sh
  ./apt_linux_dependencies.sh
  ./install_chuck.sh
  ./apt_pkg_db_updates.sh
popd > /dev/null
