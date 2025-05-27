#! /usr/bin/env bash

set -e

# https://tecadmin.net/how-to-add-swap-in-ubuntu-24-04/

if [ ! -f /swapfile ]
then
  echo "Allocating 1 GB swapfile"
  sudo fallocate -l 1G /swapfile
  sudo chmod 600 /swapfile
  sudo mkswap /swapfile

  echo "Enabling swap"
  sudo swapon /swapfile
  sudo swapon --show

  echo "Adding swap to fstab"
  cp /etc/fstab .
  sudo sed -i "$ a /swapfile none swap sw 0 0" /etc/fstab
  diff fstab /etc/fstab || true
fi

echo "Finished"
