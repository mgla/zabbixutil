#!/bin/bash
# Check if debian file for reboot notificatione exists.
# Author: Maik Glatki <maik.glatki@gmail.com>, 2014

SCRIPT=zabbix.debian.reboot-required
ZABBIXCONF=/etc/zabbix/zabbix_agentd.conf
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# check if usercommand is installed
COUNT=$(grep "$SCRIPT" $ZABBIXCONF| wc -l)
if [ $COUNT -eq 0 ]; then
	echo "installing zabbix UserParameter"
	cat $DIR/UserParameter >> $ZABBIXCONF
fi

service zabbix-agent restart
