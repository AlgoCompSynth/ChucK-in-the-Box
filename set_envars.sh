## user-defined variables
export CHUCK_VERSION=chuck-1.5.5.2

## you shouldn't need to change anything below here
if [[ "$(aplay -l | grep pisound | wc -l)" -gt "0" ]]
then
  export BLOKAS_PISOUND=1

else
  export BLOKAS_PISOUND=0

fi

export LOGFILES=$HOME/Logfiles; mkdir --parents $LOGFILES
export PROJECTS=$HOME/Projects; mkdir --parents $PROJECTS
export LOCALBIN=$HOME/.local/bin; mkdir --parents $LOCALBIN
export MINIAUDICLE_URL=https://github.com/ccrma/miniAudicle.git
export MINIAUDICLE_PATH=$PROJECTS/miniAudicle/src
export CHUCK_PATH=$MINIAUDICLE_PATH/chuck/src
export CHUGINS_PATH=$MINIAUDICLE_PATH/chugins
export DEBIAN_FRONTEND=noninteractive
export MAKE_PARALLEL_LEVEL=$(nproc)
