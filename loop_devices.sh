#!/bin/bash
# Script adb+
# Usage
# You can run any command adb provides on all your currently connected devices
# adb+ <command> is the equivalent of adb -s <serial number> <command>
#
# Examples
# adb version
# adb install apidemo.apk
# adb uninstall com.example.android.apis
# adb shell ps com.android.phone
# adb shell podof com.android.phone

#same as
#  adb devices | awk 'NR>1 && /device/ {print $1}'' | xargs -n1 -I% adb -s % install foo.apk


for line in `adb devices | grep -v "List"  | awk '{print $1}'`
do
  device=`echo $line | awk '{print $1}'`
  echo "$device $@ ..."
  #adb -s $device $@
done
