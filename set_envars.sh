echo "Setting environment variables"
export CHUCK_VERSION="chuck-1.5.5.2"
export MAKE_PARALLEL_LEVEL=$(nproc)
#export MAKE_PARALLEL_LEVEL=1 # for low-RAM systems
export LOGFILES=$HOME/Logfiles
export DEBIAN_FRONTEND=noninteractive
export CHUGIN_DEST=$HOME/.local
export CHUGIN_PATH=$HOME/.local/lib/chuck
export LLVM_VERSION=14
