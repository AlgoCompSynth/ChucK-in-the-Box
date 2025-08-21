#! /usr/bin/env bash

set -e

echo ""
echo "*** Container Hosting ***"

source ../set_envars.sh
export LOGFILE=$LOGFILES/container-hosting.log
rm --force $LOGFILE

distributor=$(lsb_release --id --short)
if [[ "$distributor" == "Ubuntu" || "$distributor" == "Debian" ]]
then
  sudo apt-get install --assume-yes \
    podman \
    uidmap \
    >> $LOGFILE 2>&1
fi

pushd $PROJECTS > /dev/null
  rm -fr distrobox
  git clone https://github.com/89luca89/distrobox.git \
    >> $LOGFILE 2>&1
  cd distrobox
  sudo ./install \
    >> $LOGFILE 2>&1
popd > /dev/null

echo "*** Finished Container Hosting ***" | tee --append $LOGFILE
