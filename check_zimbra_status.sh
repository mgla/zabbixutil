#!/bin/bash
# Script to check zimbra status
# error codes
# 0 OK
# 1 zimbra does not report "running" but something else
# 2 status file does not exist
# 3 status file is too old
# 

if [ "$#" -ne 1 ]; then
  echo "illegal number of arguments (give exactly one)"
  exit 1
fi

#service to check
CHECK=$1

FILE='/var/run/zimbra.status'
DATE=`date +%s`
TSTAMP=`stat -c %Z $FILE`
AGE=`expr $DATE - $TSTAMP`

TIME_LIMIT=300 # in seconds

# check if file does not exist
if [ ! -f $FILE ]; then
  echo 2
  exit
fi

if [ $AGE -gt $TIME_LIMIT ]; then ##too old
  echo 3
  exit
fi


#get status
STATUS=`grep $CHECK $FILE| awk '{print $2}'`

if [ "$STATUS" != "Running" ]; then
  echo 1
  exit
fi

echo 0
