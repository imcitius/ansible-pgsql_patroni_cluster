#!/bin/bash
echo "{"
echo '"data":['
for i in `ps ax | grep php-fpm | awk '{print $7}' | sort | uniq`
do
    echo '{ "{#POOLNAME}":"'$i'" },'
done
echo '{ "{#POOLNAME}":"" }'


echo "]"
echo  "}"

#cat <<-_EOF 
# {
#     "data":[
#         { "{POOLNAME}":"pool1" },
#         { "{POOLNAME}":"pool2" },
#         { "{POOLNAME}":"pool3" },
#         { "{POOLNAME}":"pool4" }
#     ]
# }
#_EOF
