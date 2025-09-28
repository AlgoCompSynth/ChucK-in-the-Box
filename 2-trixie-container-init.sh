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
echo "Creating debian-trixie distrobox -"
echo "This will take some time to download"
echo "and install packages."
echo ""
echo ""
/usr/bin/time distrobox assemble create

echo ""
echo "Setting up debian-trixie command line"
/usr/bin/time distrobox enter debian-trixie -- ./scripts/apt-packages.sh \
  >> $LOGFILE 2>&1
/usr/bin/time distrobox enter debian-trixie -- ./scripts/apt-audio-plumbing.sh \
  >> $LOGFILE 2>&1
/usr/bin/time distrobox enter debian-trixie -- ./scripts/apt-terminal-setup.sh \
  >> $LOGFILE 2>&1
cp --recursive $HOME/.ssh $HOME/dbx-homes/debian-trixie/

/usr/bin/time distrobox enter debian-trixie -- ./scripts/clone-ccrma-repos.sh
/usr/bin/time distrobox enter debian-trixie -- ./scripts/install-default-deps.sh

echo "* Finished Trixie Container Init *" | tee --append $LOGFILE
echo ""
