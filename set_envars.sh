echo "Setting environment variables"
export CHUCK_VERSION="chuck-1.5.5.2"
export CHUGL_VERSION="main"
export MAKE_PARALLEL_LEVEL=$(nproc)
#export MAKE_PARALLEL_LEVEL=1 # use this if needed on low-RAM systems
export LOGFILES=$HOME/Logfiles
export DEBIAN_FRONTEND=noninteractive
export CHUGIN_PATH=/usr/local/lib/chuck
export LLVM_VERSION=19

export DBX_CONTAINER_MANAGER="podman"
export DBX_CONTAINER_IMAGE="docker.io/library/debian:trixie-backports"
export DBX_CONTAINER_NAME="ChucK-in-the-Box"
export DBX_CONTAINER_CUSTOM_HOME="$HOME/$DBX_CONTAINER_NAME-Home"
