#!/bin/bash
# Installscript

SCRIPT=zabbix.apt.updates.security
ZABBIXCONF=/etc/zabbix/zabbix_agentd.conf
# run-parts does not run files containing periods
CRONSCRIPT=$(echo $SCRIPT| sed 's/\./_/g')
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

set -x
# Cronjob for updating
install $DIR/cronjob /etc/cron.hourly/$CRONSCRIPT
install $DIR/$SCRIPT /usr/local/bin/$SCRIPT
set +x

COUNT=$(grep "apt.updates.security" $ZABBIXCONF| wc -l)
if [ $COUNT -eq 0 ]; then
	echo "installing zabbix UserParameter"
	cat $DIR/UserParameter >> $ZABBIXCONF
fi

service zabbix-agent restart
