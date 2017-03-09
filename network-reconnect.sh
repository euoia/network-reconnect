#!/usr/bin/env bash

LOG_FILE=/var/log/network-reconnect/network-reconnect.log

LOG_FILE_SIZE=$(du --bytes ../temperature-monitor/log.js | awk '{print $1}')

if (( $LOG_FILE_SIZE > 1000000 )); then
	rm $LOG_FILE
	echo "$(date) Removed log file, reached 1MB." > $LOG_FILE
fi

ping -c 3 -W 10 8.8.8.8 >/dev/null

if [ $? -ne 0 ]; then
	echo "$(date) Internet problem detected, restarting network-manager." >> $LOG_FILE
	service network-manager restart
else
	echo "$(date) No problem detected." >> $LOG_FILE
fi

