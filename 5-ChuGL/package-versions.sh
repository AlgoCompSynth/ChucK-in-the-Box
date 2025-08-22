#! /usr/bin/env bash

set -e

echo "" | tee --append $LOGFILE
echo "Checking package versions" | tee --append $LOGFILE
for pkg in \
  cmake \
  libcanberra-gtk3-module \
  libgl-dev \
  libwayland-bin \
  libwayland-dev \
  libx11-dev \
  libxcursor-dev \
  libxi-dev \
  libxinerama-dev \
  libxkbcommon-x11-dev \
  libxrandr-dev
do
  dpkg-query --list "$pkg" \
    | grep "$pkg" \
    | sed 's;\t; ;g' \
    | sed 's;  *; ;g' \
    | tee --append $LOGFILE
done

echo "" | tee --append $LOGFILE
echo "Done!" | tee --append $LOGFILE
