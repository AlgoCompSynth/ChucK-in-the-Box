#! /usr/bin/env bash

set -e

pushd app_scripts > /dev/null
for script in \
  R_setup.sh \
  developer_packages.sh \
  audio_packages.sh \
  Positron.sh
do
  ./$script
done
popd > /dev/null
