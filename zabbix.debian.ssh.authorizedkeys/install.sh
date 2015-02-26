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
# Fix obsolete config
sed -i "s,^\(UserParameter=debian\.ssh\.authorizedkeys\),#\1," /etc/zabbix/zabbix_agentd.conf
# UserParameter
install --mode=644 $DIR/conf /etc/zabbix/zabbix_agentd.d/$SCRIPT.conf

# Restart Zabbix service.
service zabbix-agent restart
