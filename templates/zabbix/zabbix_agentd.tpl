PidFile=/run/zabbix/zabbix_agentd.pid
LogFile=/var/log/zabbix/zabbix_agentd.log
Include=/etc/zabbix/zabbix_agentd.d
LogFileSize=0
Server={{ zabbix_ip }}
ServerActive={{ zabbix_ip }}
UserParameter=netstat[*], /etc/zabbix/externalscripts/netstat.sh "none" $1 $2
UserParameter=iostat[*], /etc/zabbix/externalscripts/iostat.sh $1 $2 $3 $4
UserParameter=iostat2[*], /etc/zabbix/externalscripts/iostat2.sh $1 $2 $3 $4
UserParameter=nginx[*],/etc/zabbix/externalscripts/nginx-stats.sh "none" "$1" "$2"
UserParameter=connection_port[*],/etc/zabbix/externalscripts/connection_port.sh "none" "$1"
UserParameter=php_workers_discovery[*],/etc/zabbix/externalscripts/php_workers_discovery.sh "none" "$1"
UserParameter=pool.count[*],ps ax | grep php-fpm | grep $1| wc -l
UserParameter=mysql_slave[*],/usr/bin/mysql --defaults-extra-file=/var/lib/zabbix/.my.cnf -e 'show slave status\G'| grep $1 | awk '{print $$2}'
UserParameter=lmsensors[*],/etc/zabbix/externalscripts/lmsensors.sh "none" $1
