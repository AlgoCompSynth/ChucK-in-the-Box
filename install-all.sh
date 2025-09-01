#! /usr/bin/env bash

set -e

echo ""
echo "* Install All *"

function install_repo {
  repo=$1
  echo ""
  echo "Installing repo $repo"
  pushd ./$repo > /dev/null
    /usr/bin/time ./install.sh || true
  popd > /dev/null
}

install_repo 2-ChucK
install_repo 3-ChuGins

if [[ "$LOW_CAPACITY_SYSTEM" == "0" ]]
then
  install_repo 4-miniAudicle

  if [[ "$DISTRIBUTOR_ID" == "Ubuntu" ]]
  then
    install_repo 5-R-Audio

  fi

  if [[ "$ARCH" == "x86_64" ]]
  then
    install_repo 6-ChuGL

  fi

fi

echo "* Finished Install All *"
