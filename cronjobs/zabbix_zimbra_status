#!/bin/bash
# This scripts updates the zimbra status file.
# The temp file is needes as the zmcontrol program takes a while to run.

SFILE='/var/run/zimbra.status'
TMP=`mktemp`
sudo -u zimbra /opt/zimbra/bin/zmcontrol status | awk '{print $1,$2}' > $TMP
mv $TMP $SFILE
touch $SFILE
