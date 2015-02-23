#!/bin/bash
# Check if debian file for reboot notificatione exists.
# Author: Maik Glatki <maik.glatki@gmail.com>, 2014

SCRIPT=debian.ssh.permitrootlogin
ZABBIXCONF=/etc/zabbix/zabbix_agentd.conf
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check if item is installed.
COUNT=$(grep "$SCRIPT" $ZABBIXCONF| wc -l)
if [ $COUNT -eq 0 ]; then
	echo "Installing item: $SCRIPT."
	cat $DIR/UserParameter >> $ZABBIXCONF
	service zabbix-agent restart
else
	echo "Item already installed: $SCRIPT."
fi

