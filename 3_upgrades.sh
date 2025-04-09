#! /usr/bin/env bash

set -e

echo "Upgrading packages"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update > /dev/null 2>&1
sudo apt-get upgrade -y > /dev/null 2>&1

echo "Updating apt-file database"
sudo apt-file update > /dev/null 2>&1

echo "Updating locate database"
sudo updatedb > /dev/null 2>&1

echo "Updating manual database"
sudo mandb > /dev/null 2>&1

echo "Finished"
