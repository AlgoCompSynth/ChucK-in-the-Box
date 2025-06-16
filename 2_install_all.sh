#! /usr/bin/env bash

set -e

pushd Scripts > /dev/null
  ./apt_audio_base.sh
  ./apt_command_line_synths.sh
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
  for app in \
    OpenCL \
    FaucK \
    VCVRack
  do
    echo ""
    echo "* Begin $app"
    sleep 15
    pushd $app > /dev/null
      ./install_all.sh
    popd > /dev/null
    echo "* End $app"
  done
fi

pushd Scripts > /dev/null
  ./apt_pkg_db_updates.sh
popd > /dev/null

echo ""
echo "Finished"
