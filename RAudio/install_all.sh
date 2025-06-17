#! /usr/bin/env bash

set -e

mkdir --parents Logs
rm --force Logs/*

for script in \
  1_R.sh \
  2_developer_packages.sh \
  3_audio_packages.sh
do
  ./$script
done
