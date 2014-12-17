#!/bin/bash
# Installscript

SCRIPT=debian.kernel-uptodate
ZABBIXCONF=/etc/zabbix/zabbix_agentd.conf
# run-parts does not run files containing periods
CRONSCRIPT=$(echo $SCRIPT| sed 's/\./_/g')
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

install $DIR/zabbix.$SCRIPT /usr/local/bin/zabbix.$SCRIPT

# Check if item is installed.
COUNT=$(grep "$SCRIPT" $ZABBIXCONF| wc -l)
if [ $COUNT -eq 0 ]; then
	echo "Installing item: $SCRIPT."
	cat $DIR/UserParameter >> $ZABBIXCONF
	service zabbix-agent restart
else
	echo "Item already installed: $SCRIPT."
fi
