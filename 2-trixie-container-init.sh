#! /usr/bin/env bash

set -e

echo ""
echo "* Trixie Container Init *"

source ./set_envars.sh
export LOGFILE=$LOGFILES/2-trixie-container-init.log
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

echo ""
echo "Setting up chuck-in-the-box command line"
/usr/bin/time distrobox enter chuck-in-the-box -- ./scripts/apt-packages.sh \
  >> $LOGFILE 2>&1
/usr/bin/time distrobox enter chuck-in-the-box -- ./scripts/apt-audio-plumbing.sh \
  >> $LOGFILE 2>&1
/usr/bin/time distrobox enter chuck-in-the-box -- ./scripts/apt-terminal-setup.sh \
  >> $LOGFILE 2>&1
cp --recursive $HOME/.ssh $HOME/dbx-homes/chuck-in-the-box/

/usr/bin/time distrobox enter chuck-in-the-box -- ./scripts/clone-ccrma-repos.sh
/usr/bin/time distrobox enter chuck-in-the-box -- ./scripts/install-default-deps.sh

echo "* Finished Trixie Container Init *" | tee --append $LOGFILE
echo ""
