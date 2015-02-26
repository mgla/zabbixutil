#!/bin/bash
# Installer for authorized_keys check script.
# Author: Maik Glatki <maik.glatki@gmail.com>, 2015

SCRIPT=debian.ssh.authorizedkeys
ZABBIXCONF=/etc/zabbix/zabbix_agentd.conf
# run-parts does not run files containing periods
CRONSCRIPT=$(echo "zabbix.$SCRIPT" | sed 's/\./_/g')
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

INSTALLED=$(dpkg -s libfile-homedir-perl 2> /dev/null | grep -c "install ok installed")
if [ $INSTALLED -eq 0 ]; then
	apt-get update
	apt-get -y --no-install-recommends install libfile-homedir-perl
fi

# Cronjobs and programs
install $DIR/zabbix.$SCRIPT /usr/local/bin/zabbix.$SCRIPT
install $DIR/cronjob /etc/cron.hourly/$CRONSCRIPT
# UserParameter
install $DIR/conf /etc/zabbix/zabbix_agentd.d/$SCRIPT.conf

## Check if item is installed.
#COUNT=$(grep "$SCRIPT" $ZABBIXCONF| wc -l)
#if [ $COUNT -eq 0 ]; then
#	echo "Installing item: $SCRIPT."
#	cat $DIR/UserParameter >> $ZABBIXCONF
#	service zabbix-agent restart
#else
#	echo "Item already installed: $SCRIPT."
#fi

