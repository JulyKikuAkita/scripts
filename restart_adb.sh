#!/bin/bash
# Restart adb if adb device count not equal to TTL of after COUNT retries
# Modify TTL to update device count

TTL=6
COUNT=0

while [[ `adb devices | awk 'NR>1 && /device/ {print $1}' | wc -l` -ne $TTL && $COUNT -lt 10 ]]
do
        `adb kill-server`
        sleep 5
        let COUNT+=1
        echo "Retrying $COUNT times"
done

adb devices
~                  
