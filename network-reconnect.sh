#!/usr/bin/env bash

ping -c 3 -W 10 8.8.8.8 >/dev/null

if [ $? -ne 0 ]; then
	echo "$(date) Internet problem detected, restarting network-manager." >> $LOG_FILE
	service networking restart
	rm -f /var/run/wpa_supplicant/wlan0
	wpa_supplicant -B -iwlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf -Dwext
	service networking restart
	dhclient wlan0
else
	echo "$(date) No problem detected." >> $LOG_FILE
fi

