## greeting
echo "Setting environment variables"

export RENDER_MODE=cpu
#export RENDER_MODE=nvidia # use this if you have an NVIDIA GPU

## user-defined variables
export CHUCK_VERSION=chuck-1.5.5.2
export CHUGL_VERSION=main
export POSITRON_VERSION="2025.08.0-130"

## you shouldn't need to change anything below here
export LLVM_VERSION=19
export ARCH=$(uname -m)
echo "ARCH: $ARCH"

export RAM_KBYTES=$(grep 'MemTotal:' /proc/meminfo | sed 's/MemTotal:  *//' | sed 's/ .*$//')
echo "RAM_KBYTES: $RAM_KBYTES"
if [[ "$RAM_KBYTES" -gt "3500000" ]]
then
  export CMAKE_PARALLEL_LEVEL=$(nproc)
else
  export CMAKE_PARALLEL_LEVEL=1 # use this if needed on low-RAM systems
fi
echo "CMAKE_PARALLEL_LEVEL: $CMAKE_PARALLEL_LEVEL"
export MAKE_PARALLEL_LEVEL=$CMAKE_PARALLEL_LEVEL
echo "MAKE_PARALLEL_LEVEL: $MAKE_PARALLEL_LEVEL"

if [[ "$RAM_KBYTES" -le "3500000" || "$(nproc)" -lt "4" ]]
then
  export LOW_CAPACITY=1
  echo "LOW CAPACITY SYSTEM!"
else
  export LOW_CAPACITY=0
fi

export LOGFILES=$HOME/Logfiles
export PROJECTS=$HOME/Projects
export LOCALBIN=$HOME/.local/bin
export CHUGIN_PATH=/usr/local/lib/chuck
export DEBIAN_FRONTEND=noninteractive

export DBX_CONTAINER_MANAGER=podman
export DBX_CONTAINER_HOME_PREFIX=$HOME/dbx-homes
export DBX_CONTAINER_NAME=CitB-$ARCH-$RENDER_MODE
export DBX_CONTAINER_HOSTNAME=dbx-$DBX_CONTAINER_NAME
export DBX_CONTAINER_IMAGE=quay.io/toolbx/ubuntu-toolbox:24.04
export DBX_CONTAINER_DIRECTORY=$DBX_CONTAINER_HOME_PREFIX/$DBX_CONTAINER_NAME

if [[ "$ARCH" = "x86_64" ]]
then
  export POSITRON_PACKAGE=Positron-$POSITRON_VERSION-x64.deb
  export POSITRON_URL=https://cdn.posit.co/positron/dailies/deb/x86_64/$POSITRON_PACKAGE
elif [[ "$ARCH" = "aarch64" ]]
then
  export POSITRON_PACKAGE=Positron-$POSITRON_VERSION-arm64.deb
  export POSITRON_URL=https://cdn.posit.co/positron/dailies/deb/arm64/$POSITRON_PACKAGE
else
  echo "Unsupported architecture!"
  exit -1
fi
