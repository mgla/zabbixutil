REM Installs the zabbix agent. Run as admin
REM Author: Maik Glatki
C:\
cd C:\zabbix
zabbix_agentd.exe --config C:\zabbix\zabbix_agentd.conf --install
pause
