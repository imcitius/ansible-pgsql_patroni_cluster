for i in `iostat -x 1 2| grep "$1 " | awk '{print $'$2'}'`
do
#    echo $i
    ls >/dev/null
done
echo $i
