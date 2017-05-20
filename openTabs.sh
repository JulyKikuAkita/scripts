#!/bin/bash
# File: ~/launch_dev.sh

function new_tab() {
  TAB_NAME=$1
  COMMAND1=$2
  COMMAND2=$2
  osascript \
    -e "tell application \"Terminal\"" \
    -e "tell application \"System Events\" to keystroke \"t\" using {command down}" \
    -e "do script \"printf '\\\e]1;$TAB_NAME\\\a'; $COMMAND1\" in front window" \
    -e "do script \"printf '\\\e]1;$TAB_NAME\\\a'; $COMMAND2\" in front window" \
    -e "end tell" > /dev/null
}

# Let's make a new tab called "My Projects", change to the
# projects directory, and list the contents.
#new_tab "Scripts" "cd ~/Documents/workspace/scripts; ls -l"

# Let's also open up our deployment scripts directory
# too -- that would also be handy!
#cmd='appium --default-capabilities \'{"deviceReadyTimeout": 20, "appActivity": "com.tagged.activity.LaunchActivity", "appWaitActivity": "com.tagged.activity.LaunchActivity", "appWaitPackage": "com.taggedapp.debug", "locale":"en"}\'
cmd1='adb shell getprop Ads VERBOSE'
cmd2='adb shell setprop Ads VERBOSE'
cmd3='adb logcat -v time | grep -e "Ads"'
new_tab "ADB Log" $cmd1 $cmd3
