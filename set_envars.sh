echo "Setting environment variables"
export CHUCK_VERSION="chuck-1.5.5.2"
export CHUGL_VERSION="main"
export MAKE_PARALLEL_LEVEL=$(nproc)
#export MAKE_PARALLEL_LEVEL=1 # use this if needed on low-RAM systems
export LOGFILES=$HOME/Logfiles
export DEBIAN_FRONTEND=noninteractive
export CHUGIN_PATH=/usr/local/lib/chuck
export LLVM_VERSION=19

export CONTAINER_DISTRO="ubuntu:noble"
export CONTAINER_DISTRO_4FILENAME=$(echo $CONTAINER_DISTRO | sed 's/:/_/' | sed 's/-/_/')
export DBX_CONTAINER_MANAGER="podman"
export DBX_CONTAINER_IMAGE="docker.io/library/${CONTAINER_DISTRO}"
export DBX_CONTAINER_NAME="ChucK-in-the-Box-${CONTAINER_DISTRO_4FILENAME}"
export DBX_CONTAINER_CUSTOM_HOME="$HOME/$DBX_CONTAINER_NAME-Home"
