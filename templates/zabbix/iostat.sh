cat /proc/diskstats | grep "$1 " | awk '{print $'$2'}'
