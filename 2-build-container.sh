#! /usr/bin/env bash

set -e

echo ""
echo "* Build Container *"

source ./set_envars.sh

if [[ "$MAKE_PARALLEL_LEVEL" == "1" ]]
then
  echo "Low capacity system - container hosting not supported!!"
  echo "Exiting with error code -255"
  exit -255

fi

export LOGFILE=$LOGFILES/2-build-container.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

./scripts/apt-container-hosting.sh

echo ""
echo ""
echo "Creating boxed-chuck distrobox -"
echo "This will take some time to download"
echo "and install packages."
echo ""
echo ""
/usr/bin/time distrobox assemble create

echo "Setting up container"
cp --recursive $HOME/.ssh $HOME/dbx-homes/boxed-chuck/
/usr/bin/time distrobox enter boxed-chuck -- ./scripts/upgrade-system.sh
/usr/bin/time distrobox enter boxed-chuck -- ./scripts/apt-command-line.sh
/usr/bin/time distrobox enter boxed-chuck -- ./scripts/apt-terminal-setup.sh
/usr/bin/time distrobox enter boxed-chuck -- ./scripts/clone-ccrma-repos.sh

echo ""
echo "Installing applications"
/usr/bin/time distrobox enter boxed-chuck -- ./scripts/chuck.sh
/usr/bin/time distrobox enter boxed-chuck -- ./scripts/default-chugins.sh
/usr/bin/time distrobox enter boxed-chuck -- ./scripts/warpbuf-chugin.sh
/usr/bin/time distrobox enter boxed-chuck -- ./scripts/faust-chugin.sh
/usr/bin/time distrobox enter boxed-chuck -- ./scripts/fluidsynth-chugin.sh
/usr/bin/time distrobox enter boxed-chuck -- ./scripts/miniaudicle.sh
/usr/bin/time distrobox enter boxed-chuck -- ./scripts/probe-ChucK.sh

echo ""
echo "Updating package databases in container"
/usr/bin/time distrobox enter boxed-chuck -- sudo apt-file update \
  >> $LOGFILE 2>&1
/usr/bin/time distrobox enter boxed-chuck -- sudo updatedb \
  >> $LOGFILE 2>&1

echo "* Finished Build Container *"
