#! /usr/bin/env bash

set -e

echo ""
echo "** Install Apps ***"

pushd Scripts > /dev/null
  ./apt_audio_base.sh
  ./apt_linux_dependencies.sh
  ./install_miniaudicle.sh
  ./apt_pkg_db_updates.sh
popd > /dev/null

echo "** Finished Install Apps ***"
