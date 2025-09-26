#! /usr/bin/env bash

set -e

echo ""
echo "** PiOS Enlarge Swap **"

# https://pimylifeup.com/raspberry-pi-swap-file/
sudo dphys-swapfile swapoff
sleep 10
diff configs/dphys-swapfile /etc/dphys-swapfile || true
sudo cp configs/dphys-swapfile /etc/dphys-swapfile
sudo dphys-swapfile setup
sudo dphys-swapfile swapon

echo "** Finished PiOS Enlarge Swap **"
