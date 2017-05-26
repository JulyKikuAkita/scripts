#!/bin/bash
cd ./libs;
java -jar "selenium-server-standalone-2.45.0.jar" org.openqa.grid.selenium.GridLauncher -role hub -host 192.168.10.154 -port 4444 -newSessionWaitTimeout 480000 -timeout 60
~                                                                                                                                                                         
~  
