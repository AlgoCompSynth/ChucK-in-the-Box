#! /usr/bin/env bash

set -e

echo ""
echo "* Install All *"

for repo in \
  2-ChucK \
  3-ChuGins \
  4-miniAudicle \
  5-R-Audio
do
  echo ""
  echo "Installing repo $repo"
  pushd ./$repo > /dev/null
    /usr/bin/time ./install.sh
  popd > /dev/null
done

echo "* Finished Install All *"
