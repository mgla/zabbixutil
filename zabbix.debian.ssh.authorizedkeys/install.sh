#!/bin/bash
# Installer for authorized_keys check script.
# Author: Maik Glatki <maik.glatki@gmail.com>, 2015

SCRIPT=debian.ssh.authorizedkeys
ZABBIXCONF=/etc/zabbix/zabbix_agentd.conf
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

apt-get update
apt-get -y -R install libfile-homedir-perl

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

