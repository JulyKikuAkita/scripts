#!/bin/bash
appAct="com.bignerdrach.criminalintent.activity.LaunchActivity
appWaitPkg="com.biggerdranch"

for i in "$@"
do
case $i in
    -n=*|--index=*)
    var_index="${i#*=}"
    offset=`expr $var_index - 1`
    index=$var_index
    ;;
    --default)
    DEFAULT=YES
    ;;
    *)
    # unknown option
    ;;
esac
done

TEST_HOME=~/android-real-devices-lab-setup/src
LOG_HOME=$TEST_HOME/logs

echo "====== TEST_HOME: $TEST_HOME"
echo "====== LOG_HOME: $LOG_HOME"

# udid="${ip}:${device_port}"
# echo "====== new udid: $udid"

x=$(($index*10))
port=`expr 4725 + $x`

echo "======== COMMAND IS: appium --session-override --strict-caps --nodeconfig $HOME/android$index.json -p $port --command-timeout 60 --log $LOG_HOME/log$index.txt "
echo "--default-capabilities" '{"deviceReadyTimeout": "20", "udid": "'"$udid"'", "deviceName": "'"$device_name"'", "appActivity": "$appAct", "appWaitActivity": "$appAct", "appWaitPackage": "$appWaitPkg"}'
#appium --session-override --strict-caps --nodeconfig $TEST_HOME/android$index.json -p $port --command-timeout 60 --log $LOG_HOME/log$index.txt --default-capabilities '{"deviceReadyTimeout": 20, "udid": "'"$udid"'", "deviceName": "'"$device_name"'", "appActivity": "$appAct", "appWaitActivity": "$appAct", "appWaitPackage": "$appWaitPkg"}'

while true
do
  appium --session-override --strict-caps --nodeconfig $TEST_HOME/android$index.json -p $port --command-timeout 60 --log $LOG_HOME/log$index.txt --default-capabilities '{"deviceReadyTimeout": 20, "appActivity": "$appAct", "appWaitActivity": "$appAct", "appWaitPackage": "$appWaitPkg"}'
  echo "============ PROCESS EXITED ==========="
  sleep 5
done;
