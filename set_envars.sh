export CHUCK_VERSION=chuck-1.5.5.2
export CHUCK_DRIVERS="linux-alsa"
export LOGFILES=$HOME/Logfiles; mkdir --parents $LOGFILES
export PROJECTS=$HOME/Projects; mkdir --parents $PROJECTS
export LOCALBIN=$HOME/.local/bin; mkdir --parents $LOCALBIN
export MINIAUDICLE_URL=https://github.com/ccrma/miniAudicle.git
export MINIAUDICLE_PATH=$PROJECTS/miniAudicle/src
export CHUCK_PATH=$MINIAUDICLE_PATH/chuck/src
export CHUGINS_PATH=$MINIAUDICLE_PATH/chugins
export CHUGINS_LIB_PATH=/usr/local/lib/chuck
export DEBIAN_FRONTEND=noninteractive

export RAM_KBYTES=$(grep 'MemTotal:' /proc/meminfo | sed 's/MemTotal:  *//' | sed 's/ .*$//')
if [[ "$RAM_KBYTES" -gt "3500000" ]]
then
  export MAKE_PARALLEL_LEVEL=$(nproc)

else
  export MAKE_PARALLEL_LEVEL=1

fi

if [[ "$(aplay -l | grep pisound | wc -l)" -gt "0" ]]
then
  export BLOKAS_PISOUND=1

else
  export BLOKAS_PISOUND=0

fi

export DBX_CONTAINER_MANAGER="podman"
export DBX_CONTAINER_NAME="trixie-backports"
export DBX_CONTAINER_IMAGE="docker.io/library/debian:trixie-backports"
export DBX_CONTAINER_HOME_PREFIX="$HOME/dbx-homes"
export DBX_CONTAINER_DIRECTORY="$DBX_CONTAINER_HOME_PREFIX/$DBX_CONTAINER_NAME"
