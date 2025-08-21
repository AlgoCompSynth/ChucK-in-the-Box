#! /usr/bin/env bash

set -e

echo ""
echo "* Install All *"

pushd ./1-Desktop-Setup > /dev/null
  ./desktop-setup.sh
popd >/dev/null

for repo in \
  2-ChucK \
  3-ChuGins \
  4-miniAudicle \
  5-ChuGL
do
  echo ""
  echo "Installing repo $repo"
  pushd ./$repo > /dev/null
    /usr/bin/time ./install.sh
  popd > /dev/null
done

echo "* Finished Install All *"
