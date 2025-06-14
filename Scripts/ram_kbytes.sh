export RAM_KBYTES=`grep MemTotal /proc/meminfo | sed 's/^MemTotal:  *//' | sed 's/ .*$//'`
