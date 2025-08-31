#! /usr/bin/env bash

set -e

echo ""
echo "* Install All *"

function install_repo {
  repo=$1
  echo ""
  echo "Installing repo $repo"
  pushd ./$repo > /dev/null
    /usr/bin/time ./install.sh
  popd > /dev/null
}

for repo in \
  2-ChucK \
  3-ChuGins
do
  install_repo $repo
done

if [[ "$LOW_CAPACITY_SYSTEM" == "0" ]]
then

  for repo in \
    4-miniAudicle \
    5-R-Audio
  do
    install_repo $repo
  done

fi

echo "* Finished Install All *"
