echo "Setting environment variables"
## user-defined variables
export CHUCK_VERSION=chuck-1.5.5.2
export CHUGL_VERSION=main
export CONTAINER_DISTRO=debian:bookworm

export MAKE_PARALLEL_LEVEL=$(nproc)
#export MAKE_PARALLEL_LEVEL=1 # use this if needed on low-RAM systems

export RENDER_MODE=cpu
#export RENDER_MODE=nvidia # use this if you have an NVIDIA GPU

## you shouldn't need to change anything below here
export ARCH=$(uname -m)
export LOGFILES=$HOME/Logfiles
export PROJECTS=$HOME/Projects
export LOCALBIN=$HOME/.local/bin
export DEBIAN_FRONTEND=noninteractive
export CHUGIN_PATH=/usr/local/lib/chuck
export DBX_CONTAINER_MANAGER=podman
export DBX_CONTAINER_HOME_PREFIX=$HOME/dbx-homes
export CONTAINER_DISTRO_4FILENAME=$(echo $CONTAINER_DISTRO | sed 's/:/_/' | sed 's/-/_/')
export DBX_CONTAINER_IMAGE=docker.io/library/${CONTAINER_DISTRO}
export DBX_CONTAINER_NAME=CitB-${CONTAINER_DISTRO_4FILENAME}-$ARCH-$RENDER_MODE
export DBX_CONTAINER_DIRECTORY=$DBX_CONTAINER_HOME_PREFIX/$DBX_CONTAINER_NAME
export DBX_CONTAINER_HOSTNAME=dbx-$DBX_CONTAINER_NAME

if [[ "$CONTAINER_DISTRO" == "debian:bookworm" ]]
then
  export LLVM_VERSION=14
else
  export LLVM_VERSION=19
fi
