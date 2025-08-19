echo "Setting environment variables"
export CHUCK_VERSION="chuck-1.5.5.2"
export CHUGL_VERSION="main"
export MAKE_PARALLEL_LEVEL=$(nproc)
#export MAKE_PARALLEL_LEVEL=1 # for low-RAM systems
export LOGFILES=$HOME/Logfiles
export DEBIAN_FRONTEND=noninteractive
export CHUGIN_PATH=/usr/local/lib/chuck
export LLVM_VERSION=14
