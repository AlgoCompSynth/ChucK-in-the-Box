#! /usr/bin/env bash

set -e

source ../set_envars.sh

if [[ "$LOW_CAPACITY" == "1" ]]
then
  echo "LOW CAPACITY SYSTEM!"
  echo "Not installing R / R packages"
  exit 0
fi

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
