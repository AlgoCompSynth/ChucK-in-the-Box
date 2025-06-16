#! /usr/bin/env bash

set -e

pushd Scripts > /dev/null
  ./apt_audio_base.sh
popd > /dev/null

echo ""
echo ""
source Scripts/ram_kbytes.sh
if [[ "$RAM_KBYTES" -lt "3500000" ]]
then
  echo "Insufficient RAM for GUI apps"
  pushd Scripts > /dev/null
    ./apt_linux_dependencies.sh
    ./install_chuck.sh
    ./apt_pkg_db_updates.sh
  popd > /dev/null
else
  echo "GUI apps enabled"
  pushd Scripts > /dev/null
    ./apt_command_line_synths.sh
  popd > /dev/null
  pushd FaucK > /dev/null
    ./install_all.sh
  popd > /dev/null
fi

pushd Scripts > /dev/null
  ./apt_pkg_db_updates.sh
popd > /dev/null

echo ""
echo "Finished"
