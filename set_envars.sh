## user-defined variables
export CHUCK_VERSION=chuck-1.5.5.2

## you shouldn't need to change anything below here
export ARCH=$(uname -m)
export DISTRIBUTOR_ID=$(lsb_release --id --short 2> /dev/null)
export CODENAME=$(lsb_release --codename --short 2> /dev/null)

export RAM_KBYTES=$(grep 'MemTotal:' /proc/meminfo | sed 's/MemTotal:  *//' | sed 's/ .*$//')
if [[ "$RAM_KBYTES" -gt "3500000" ]]
then
  export CMAKE_PARALLEL_LEVEL=$(nproc)

else
  export CMAKE_PARALLEL_LEVEL=1 # use this if needed on low-RAM systems

fi
export MAKE_PARALLEL_LEVEL=$CMAKE_PARALLEL_LEVEL

if [[ "$RAM_KBYTES" -le "3500000" || "$(nproc)" -lt "4" ]]
then
  export LOW_CAPACITY_SYSTEM=1

else
  export LOW_CAPACITY_SYSTEM=0

fi

export LOGFILES=$HOME/Logfiles; mkdir --parents $LOGFILES
export PROJECTS=$HOME/Projects; mkdir --parents $PROJECTS
export LOCALBIN=$HOME/.local/bin; mkdir --parents $LOCALBIN
export CHUGIN_PATH=/usr/local/lib/chuck
export DEBIAN_FRONTEND=noninteractive
