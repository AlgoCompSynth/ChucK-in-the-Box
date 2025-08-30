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

echo "Creating manifest file distrobox.ini"
echo "[$DBX_CONTAINER_NAME]" > distrobox.ini
echo "image=$DBX_CONTAINER_IMAGE" >> distrobox.ini
echo "home=$DBX_CONTAINER_DIRECTORY" >> distrobox.ini
echo "init=false" >> distrobox.ini
echo "pull=true" >> distrobox.ini
echo "root=false" >> distrobox.ini
echo "replace=false" >> distrobox.ini
echo "start_now=false" >> distrobox.ini

echo "additional_packages=\"alsa-utils apt-file ca-certificates cmake dirmngr ffmpeg file flac\"" \
  >> distrobox.ini
echo "additional_packages=\"libavcodec-dev libavdevice-dev libavfilter-dev libavformat-dev libavutil-dev\"" \
  >> distrobox.ini
echo "additional_packages=\"libpostproc-dev libsdl2-dev libswresample-dev libswscale-dev\"" \
  >> distrobox.ini
echo "additional_packages=\"fluid-soundfont-gm fluid-soundfont-gs fluidsynth libfluidsynth-dev\"" \ \
  >> distrobox.ini
echo "additional_packages=\"freepats git gnupg keyboard-configuration libicu-dev\"" \
  >> distrobox.ini
echo "additional_packages=\"libsox-dev libsox-fmt-all libsoxr-dev sox\"" \
  >> distrobox.ini
echo "additional_packages=\"lsb-release mp3splt opl3-soundfont\"" \
  >> distrobox.ini
echo "additional_packages=\"pipewire-alsa pipewire-doc \"" \
  >> distrobox.ini
echo "additional_packages=\"plocate pmidi polyphone rtkit software-properties-common\"" \
  >> distrobox.ini
echo "additional_packages=\"time tree vim wget wireplumber-doc\"" \
  >> distrobox.ini

if [[ "$RENDER_MODE" == "cpu" ]]
then
  echo "nvidia=false" >> distrobox.ini
  echo \
    "additional_flags="--env LIBGL_ALWAYS_SOFTWARE=1"" \
    >> distrobox.ini
elif [[ "$RENDER_MODE" == "nvidia" ]]
then
  echo "nvidia=true" >> distrobox.ini
  echo \
    "additional_packages=\"libffmpeg-nvenc-dev nvidia-vaapi-driver\"" \
    >> distrobox.ini
  echo \
    "additional_packages=\"libnvidia-egl-wayland1 libnvidia-egl-wayland-dev\"" \
    >> distrobox.ini
fi  

echo ""
echo "Creating Distrobox container $DBX_CONTAINER_NAME"
echo "with home directory $DBX_CONTAINER_DIRECTORY"
/usr/bin/time distrobox assemble create \
  >> $LOGFILE 2>&1

echo ""
echo "Entering $DBX_CONTAINER_NAME to perform setup."
echo "This will take some time."
/usr/bin/time distrobox enter --no-tty $DBX_CONTAINER_NAME -- ./container-setup.sh

echo ""
echo "Distrobox containers:"
distrobox list

echo ""
echo "Copying '$HOME/.ssh' into '$DBX_CONTAINER_DIRECTORY'"
echo "to enable full 'git' functionality."
cp --recursive $HOME/.ssh $DBX_CONTAINER_DIRECTORY

echo ""
echo "Entering the container--"
echo "    Exit with CTRL-D or 'exit'."
echo "    Re-enter with"
echo ""
echo "    distrobox enter $DBX_CONTAINER_NAME"

distrobox enter $DBX_CONTAINER_NAME

echo "*** Finished New Container ***" | tee --append $LOGFILE
