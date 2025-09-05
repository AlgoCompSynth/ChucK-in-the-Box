echo "Setting environment variables"

## user-defined variables
export CHUCK_VERSION=chuck-1.5.5.2
echo "CHUCK_VERSION: $CHUCK_VERSION"
export BLOKAS_PISOUND=0
#export BLOKAS_PISOUND=1
echo "BLOKAS_PISOUND: $BLOKAS_PISOUND"

## you shouldn't need to change anything below here
export ARCH=$(uname -m)
echo "ARCH: $ARCH"
export DISTRIBUTOR_ID=$(lsb_release --id --short 2> /dev/null)
echo "DISTRIBUTOR_ID: $DISTRIBUTOR_ID"
export CODENAME=$(lsb_release --codename --short 2> /dev/null)
echo "CODENAME: $CODENAME"

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
  export LOW_CAPACITY_SYSTEM=1

else
  export LOW_CAPACITY_SYSTEM=0

fi
echo "LOW_CAPACITY_SYSTEM: $LOW_CAPACITY_SYSTEM"

export LOGFILES=$HOME/Logfiles; mkdir --parents $LOGFILES
export PROJECTS=$HOME/Projects; mkdir --parents $PROJECTS
export LOCALBIN=$HOME/.local/bin; mkdir --parents $LOCALBIN
export CHUGIN_PATH=/usr/local/lib/chuck
export DEBIAN_FRONTEND=noninteractive
