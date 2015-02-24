REM Adds Zabbix Agent to Firewall
netsh advfirewall firewall add rule name="Zabbix Agent" dir=in action=allow program="c:\zabbix\zabbix_agentd.exe" enable=yes
pause
