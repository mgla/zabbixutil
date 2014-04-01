#!/bin/bash
# Installscript

SCRIPT=zabbix.https.certificate.days
ZABBIXCONF=/etc/zabbix/zabbix_agentd.conf
# run-parts does not run files containing periods
CRONSCRIPT=$(echo $SCRIPT| sed 's/\./_/g')
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

set -x
install $DIR/$SCRIPT /usr/local/bin/$SCRIPT
set +x

COUNT=$(grep "$SCRIPT" $ZABBIXCONF| wc -l)
if [ $COUNT -eq 0 ]; then
	echo "installing zabbix UserParameter"
	cat $DIR/UserParameter >> $ZABBIXCONF
fi

service zabbix-agent restart
