#!/bin/bash
export LC_ALL=""
export LANG="en_US.UTF-8"
#
if [[ -z $1 || -z $2 ]]; then
  ##### DISCOVERY #####
  PROCESSORS=`sensors 2>&1 | awk '{if (tolower($1)~"adapter") {counter +=1;}} END {for (i=1; i<=counter; i+=1) printf("CPU%1d\n", i-1); }'`
  if [[ -n ${PROCESSORS} ]]; then
    JSON="{ \"data\":["
    SEP=""
    for CPU in ${PROCESSORS}; do
      JSON=${JSON}"$SEP{\"{#CPUNAME}\":\"${CPU}\"}"
      SEP=", "
    done
    JSON=${JSON}"]}"
    echo ${JSON}
  fi
  exit 0
else
  ##### PARAMETERS #####
  HOST="$1"
  CPUNAME="$2"
  TABLE=`sensors 2>&1 | awk '{if (tolower($1)~"adapter") { counter +=1; } if (tolower($1)=="core")
      { if ($3 > temperature[counter]) temperature[counter] = $3;}}
      END {for (i=1; i<=counter; i+=1) printf ( "CPU%1d %2.1f\n", i-1, temperature[i]); }'`
  echo "${TABLE}" | awk "/${CPUNAME}/ {print \$2}" | head -n1
#
fi

