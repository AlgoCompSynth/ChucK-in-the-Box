#! /usr/bin/env bash

set -e

echo ""
echo "* Build Container *"

source ./set_envars.sh
export LOGFILE=$LOGFILES/2-build-container.log
echo "LOGFILE: $LOGFILE"
rm --force $LOGFILE

echo ""
echo ""
echo "Creating chuck-in-the-box distrobox -"
echo "This will take some time to download"
echo "and install packages."
echo ""
echo ""
/usr/bin/time distrobox assemble create

echo "Setting up container"
cp --recursive $HOME/.ssh $HOME/dbx-homes/chuck-in-the-box/
/usr/bin/time distrobox enter chuck-in-the-box -- ./scripts/upgrade-system.sh
/usr/bin/time distrobox enter chuck-in-the-box -- ./scripts/apt-command-line.sh
/usr/bin/time distrobox enter chuck-in-the-box -- ./scripts/apt-terminal-setup.sh
/usr/bin/time distrobox enter chuck-in-the-box -- ./scripts/clone-ccrma-repos.sh
echo ""
echo "Updating package databases in container"
/usr/bin/time distrobox enter chuck-in-the-box -- sudo apt-file update \
  >> $LOGFILE 2>&1
/usr/bin/time distrobox enter chuck-in-the-box -- sudo updatedb \
  >> $LOGFILE 2>&1

echo ""
echo "Installing applications"
/usr/bin/time distrobox enter chuck-in-the-box -- ./scripts/chuck.sh
/usr/bin/time distrobox enter chuck-in-the-box -- ./scripts/default-chugins.sh
/usr/bin/time distrobox enter chuck-in-the-box -- ./scripts/warpbuf-chugin.sh
/usr/bin/time distrobox enter chuck-in-the-box -- ./scripts/faust-chugin.sh
/usr/bin/time distrobox enter chuck-in-the-box -- ./scripts/fluidsynth-chugin.sh
/usr/bin/time distrobox enter chuck-in-the-box -- ./scripts/miniaudicle.sh
/usr/bin/time distrobox enter chuck-in-the-box -- ./scripts/probe-ChucK.sh

echo ""
echo "Testing ChucK from host"
./scripts/probe-ChucK.sh

echo "* Finished Build Container *"
