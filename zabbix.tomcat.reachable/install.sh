#!/bin/bash
# Install script for tiny tomcat checker.
# Author: Maik Glatki <maik.glatki@gmail.com>, 2014

SCRIPT=zabbix.tomcat.reachable
ZABBIXCONF=/etc/zabbix/zabbix_agentd.conf
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# check if usercommand is installed
COUNT=$(grep "$SCRIPT" $ZABBIXCONF| wc -l)
if [ $COUNT -eq 0 ]; then
	echo "installing zabbix UserParameter"
	cat $DIR/UserParameter >> $ZABBIXCONF
fi

service zabbix-agent restart
