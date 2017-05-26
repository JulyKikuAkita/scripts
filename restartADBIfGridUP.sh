#!/bin/bash
# crontab setup for this script
# If grid console is up, periodically check adb connection status

# If lost devices conneciotn, restart ADB when grid is up running
GRID="http://192.168.10.154:4444/grid/console#"
DEVICE_COUNT=6
DELAY=60

if [ `curl -s -o /dev/null -w "%{http_code}" $GRID` -eq 200 ];
then
    CURRENT_COUNT=`adb devices | awk 'NR>1 && NF {print $1}'  | wc -l`
    # echo $CURRENT_COUNT  #for test purpose
    while [ $CURRENT_COUNT -ne $DEVICE_COUNT ];
    do
        adb kill-server
        sleep 10
        echo $CURRENT_COUNT
        echo adb kill server...
        CURRENT_COUNT=`adb devices | awk 'NR>1 && NF {print $1}'  | wc -l`
    done
    echo "All device up, exiting..."
fi
~  
