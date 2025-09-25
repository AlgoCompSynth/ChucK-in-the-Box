while true
do
  echo ""
  vcgencmd measure_temp
  grep -i avail /proc/meminfo 
  date
  sleep 15
done
