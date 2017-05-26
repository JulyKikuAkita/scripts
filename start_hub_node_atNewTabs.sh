#!/bin/bash
#setenv alias var for TEST_HOME
#alias ll=`pwd`
TEST_HOME=`ll`
NODE_CMD="$TEST_HOME/start_node_device.sh --index="
#hh # alias to move to script directory

function new_tab() {
  TAB_NAME=$1
  COMMAND=$2
  osascript \
    -e "tell application \"Terminal\"" \
    -e "tell application \"System Events\" to keystroke \"t\" using {command down}" \
    -e "do script \"printf '\\\e]1;$TAB_NAME\\\a'; $COMMAND\" in front window" \
    -e "end tell" > /dev/null
}

# Start Selenium hub
new_tab "hub" "$TEST_HOME/start_hub.sh"
sleep 3 #starting hub

# Register node on each tab
for i in {1..6}
do
        new_tab "device $i" "$NODE_CMD$i"
done


# minitor device healthness
new_tab "monitoring" "$TEST_HOME/restart_adb.sh"
