#! /usr/bin/env bash

set -e

echo ""
echo "** Install 'jackd2' **"

echo ""
echo ""
echo "Installing 'jackd2'"
echo "Answer the configuration question with 'No'"
echo ""
sleep 10
sudo apt-get install --no-install-recommends -y \
  alsaplayer-jack \
  jackd2 \

echo "** Finished Install 'jackd2' **"
