#! /usr/bin/env bash

set -e

echo ""
echo "Setting environment variables"
export DBX_CONTAINER_IMAGE="docker.io/library/debian:trixie-backports"
export DBX_CONTAINER_NAME="CitB-CUDA"
export DBX_CONTAINER_HOME_PREFIX="$HOME/dbx-homes"
export DBX_CONTAINER_DIRECTORY="$DBX_CONTAINER_HOME_PREFIX/$DBX_CONTAINER_NAME"
export DBX_CONTAINER_HOSTNAME=$DBX_CONTAINER_NAME

echo ""
echo "Removing any existing distrobox container $DBX_CONTAINER_NAME"
distrobox rm --force $DBX_CONTAINER_NAME

echo "Removing any existing distrobox home directory $DBX_CONTAINER_DIRECTORY"
rm -rf $DBX_CONTAINER_DIRECTORY

echo "Pulling $DBX_CONTAINER_IMAGE"
podman pull $DBX_CONTAINER_IMAGE

echo "Creating distrobox $DBX_CONTAINER_NAME"
distrobox create \
  --image $DBX_CONTAINER_IMAGE \
  --name $DBX_CONTAINER_NAME \
  --hostname $DBX_CONTAINER_HOSTNAME \
  --nvidia \
  --pull \
  --home $DBX_CONTAINER_DIRECTORY \
  --additional-packages "keyboard-configuration libicu-dev lsb-release" \
  --additional-packages "libffmpeg-nvenc-dev libnvidia-egl-wayland-dev libnvidia-egl-wayland1 nvidia-vaapi-driver"

echo "Populating distrobox $DBX_CONTAINER_NAME"
distrobox enter $DBX_CONTAINER_NAME -- ./1-install.sh

echo "Finished"
