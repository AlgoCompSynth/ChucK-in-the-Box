#! /usr/bin/env bash

set -e

echo ""
echo "*** New Container ***"

source ../set_envars.sh
export LOGFILE=$LOGFILES/new-container.log
rm --force $LOGFILE

if [[ "$(distrobox list | grep $DBX_CONTAINER_NAME | wc -l)" -gt "0" ]]
then
  while true; do
    echo ""
    echo "Container $DBX_CONTAINER_NAME exists."
    read -p "Do you want to force-remove it (y/n)?" yn
    case $yn in
      [Yy]* )
        distrobox rm --force $DBX_CONTAINER_NAME
        break
        ;;
      [Nn]* ) 
        echo ""
        echo "Container $DBX_CONTAINER_NAME and container"
        echo "home directory $DBX_CONTAINER_DIRECTORY"
        echo "will not be touched!"
        echo ""
        echo "*** Finished Container Setup ***" | tee --append $LOGFILE
        exit
        ;;
      * ) echo "Please answer yes or no."
        ;;
    esac
  done
fi

if [[ -d $DBX_CONTAINER_DIRECTORY ]]
then
  while true; do
    echo ""
    echo "Container home directory $DBX_CONTAINER_DIRECTORY exists."
    read -p "Do you want to recursively force-remove it (y/n)?" yn
    case $yn in
      [Yy]* )
        rm --recursive --force $DBX_CONTAINER_DIRECTORY
        break
        ;;
      [Nn]* ) 
        break
        ;;
      * ) echo "Please answer yes or no."
        ;;
    esac
  done
fi

echo ""
echo "Creating Distrobox container $DBX_CONTAINER_NAME"
echo "with home directory $DBX_CONTAINER_DIRECTORY"
/usr/bin/time distrobox create \
  --pull \
  --additional-packages "apt-file file git lsb-release pipewire-alsa plocate time tree vim" \
  --additional-flags "--env LIBGL_ALWAYS_SOFTWARE=1" \
  >> $LOGFILE 2>&1

echo ""
echo "Entering $DBX_CONTAINER_NAME to perform setup."
echo "This will take some time."
/usr/bin/time distrobox enter --no-tty $DBX_CONTAINER_NAME -- ./container-setup.sh

echo ""
echo "Distrobox containers:"
distrobox list

while true; do
  echo ""
  echo "If you will be cloning git repos into the container,"
  echo "it is recommended to copy your host '\$HOME/.ssh'"
  echo "directory into the container's '\$HOME'."
  echo ""
  read -p "Do you want to copy it (y/n)?" yn
  case $yn in
    [Yy]* )
      cp --recursive $HOME/.ssh $DBX_CONTAINER_DIRECTORY
      break
      ;;
    [Nn]* ) 
      break
      ;;
    * ) echo "Please answer yes or no."
      ;;
  esac
done

echo ""
echo "To use the container, type"
echo ""
echo "  distrobox enter $DBX_CONTAINER_NAME"
echo ""

echo "*** Finished New Container ***" | tee --append $LOGFILE
