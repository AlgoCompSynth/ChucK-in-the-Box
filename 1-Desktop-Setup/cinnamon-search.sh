#! /usr/bin/env bash

set -e

echo "Dry-run installs of Cinnamon desktop packages:"
for pkg in \
  cinnamon \
  cinnamon-core \
  cinnamon-desktop-environment \
  task-cinnamon-desktop
do
  echo "...Testing $pkg"
  sudo apt-get install --dry-run $pkg \
    | grep -e "^Inst" \
    > $pkg.inst
done

echo "How big are they?"
wc -l *.inst \
  | sort -k 1 -nr \
  | tee cinnamon-search.txt
