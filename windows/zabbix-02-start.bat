REM starts the zabbix agent ONCE. Check Firewall afterwards
REM Author: Maik Glatki
C:\
cd C:\zabbix
zabbix_agentd.exe --config C:\zabbix\zabbix_agentd.conf --start
pause