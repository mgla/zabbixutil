#!/bin/bash
# Installscript

SCRIPT=zabbix.apt.updates.security
# run-parts does not run files containing periods
CRONSCRIPT=$(echo $SCRIPT| sed 's/\./_/g')
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

set -x
# Cronjob for updating
install $DIR/cronjob /etc/cron.hourly/$CRONSCRIPT
install $DIR/$SCRIPT /usr/local/bin/$SCRIPT
set +x
echo "installing zabbix UserParameter"
cat $DIR/UserParameter >> /etc/zabbix/zabbix_agentd.conf
