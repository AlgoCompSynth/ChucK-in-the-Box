export CHUCK_SOURCE_VERSION=chuck-1.5.5.6
export CHUCK_DRIVERS="linux-all"
export LOGFILES=$HOME/Logfiles; mkdir --parents $LOGFILES
export PROJECTS=$HOME/Projects; mkdir --parents $PROJECTS
export LOCALBIN=$HOME/.local/bin; mkdir --parents $LOCALBIN
export MINIAUDICLE_URL=https://github.com/ccrma/miniAudicle.git
export MINIAUDICLE_PATH=$PROJECTS/miniAudicle/src
export CHUCK_PATH=$MINIAUDICLE_PATH/chuck/src
export CHUGINS_PATH=$MINIAUDICLE_PATH/chugins
export CHUGINS_LIB_PATH=/usr/local/lib/chuck
export WOW_EXAMPLE=$HOME/Projects/miniAudicle/src/chuck/examples/book/digital-artists/chapter1/WowExample.ck
export DEBIAN_FRONTEND=noninteractive

export NPROC=$(nproc)
export RAM_KBYTES=$(grep 'MemTotal:' /proc/meminfo | sed 's/MemTotal:  *//' | sed 's/ .*$//')
if [[ "$RAM_KBYTES" -lt "750000" || "$NPROC" -lt "4" ]]
then
  export MAKE_PARALLEL_LEVEL="1"
  export CMAKE_PARALLEL_LEVEL="1"

else
  export MAKE_PARALLEL_LEVEL=$NPROC
  export CMAKE_PARALLEL_LEVEL=$NPROC

fi
