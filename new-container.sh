#! /usr/bin/env bash

set -e

echo ""
echo "* New Container *"

source ./set_envars.sh
echo "Removing previous container if any"
distrobox rm --force --rm-home $DBX_CONTAINER_NAME
echo ""
echo "Creating new container - installing basic packages"
echo "will take a while"
echo ""
echo ""
distrobox assemble create
echo ""
echo "Copying $HOME/.ssh to $DBX_CONTAINER_DIRECTORY"
echo "This is required for git clones"
echo ""
cp -rp $HOME/.ssh $DBX_CONTAINER_DIRECTORY

echo ""
echo "Entering container $DBX_CONTAINER_NAME"
echo "Exit with CTRL-D or 'exit'"
echo "Re-enter with 'distrobox enter $DBX_CONTAINER_NAME'"
echo ""
distrobox enter $DBX_CONTAINER_NAME

echo "* Finished New Container *" | tee --append $LOGFILE
