#!/bin/bash
##### OPTIONS VERIFICATION #####
if [[ -z "$1" || -z "$2" || -z "$3" ]]; then
  exit 1
fi
##### PARAMETERS #####
RESERVED="$1"
METRIC="$2"
STATSURL="$3"
CURL="/usr/bin/curl"
CACHE_TTL="55"
CACHE_FILE="/tmp/zabbix.nginx.`echo $STATSURL | md5sum | cut -d" " -f1`.cache"
EXEC_TIMEOUT="1"
NOW_TIME=`date '+%s'`
##### RUN #####
if [ -s "${CACHE_FILE}" ]; then
  CACHE_TIME=`stat -c"%Y" "${CACHE_FILE}"`
else
  CACHE_TIME=0
fi
DELTA_TIME=$((${NOW_TIME} - ${CACHE_TIME}))
#
if [ ${DELTA_TIME} -lt ${EXEC_TIMEOUT} ]; then
  sleep $((${EXEC_TIMEOUT} - ${DELTA_TIME}))
elif [ ${DELTA_TIME} -gt ${CACHE_TTL} ]; then
  echo "" >> "${CACHE_FILE}" # !!!
  DATACACHE=`${CURL} -sS --insecure --max-time ${EXEC_TIMEOUT} "${STATSURL}" 2>&1`
  echo "${DATACACHE}" > "${CACHE_FILE}" # !!!
  chmod 640 "${CACHE_FILE}"
fi
#
if [ "${METRIC}" = "active" ]; then
  cat "${CACHE_FILE}" | grep "Active connections:" | cut -d ' ' -f3
fi
if [ "${METRIC}" = "accepts" ]; then
  cat "${CACHE_FILE}" | sed -n '3p' | cut -d" " -f2
fi
if [ "${METRIC}" = "handled" ]; then
  cat "${CACHE_FILE}" | sed -n '3p' | cut -d" " -f3
fi
if [ "${METRIC}" = "requests" ]; then
  cat "${CACHE_FILE}" | sed -n '3p' | cut -d" " -f4
fi
if [ "${METRIC}" = "reading" ]; then
  cat "${CACHE_FILE}" | grep "Reading" | cut -d':' -f2 | cut -d' ' -f2
fi
if [ "${METRIC}" = "writing" ]; then
  cat "${CACHE_FILE}" | grep "Writing" | cut -d':' -f3 | cut -d' ' -f2
fi
if [ "${METRIC}" = "waiting" ]; then
  cat "${CACHE_FILE}" | grep "Waiting" | cut -d':' -f4 | cut -d' ' -f2
fi
#
exit 0
