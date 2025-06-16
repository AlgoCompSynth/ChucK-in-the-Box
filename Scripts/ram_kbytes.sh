export RAM_KBYTES=`grep "MemTotal:  *" /proc/meminfo | sed 's/MemTotal:  *//' | sed 's/ .*$//'`
echo "RAM_KBYTES: $RAM_KBYTES"
