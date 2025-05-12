#! /usr/bin/env bash

set -e

echo "*** Edit swapfile size ***"

echo "Editing swapfile size"
# https://pimylifeup.com/raspberry-pi-swap-file/
sudo dphys-swapfile swapoff
sleep 5
diff dphys-swapfile /etc/dphys-swapfile || true
sudo cp dphys-swapfile /etc/dphys-swapfile
sudo dphys-swapfile setup
sudo dphys-swapfile swapon
