#!/usr/bin/env bash
set -e

ping -c 3 -W 10 8.8.8.8 >/dev/null

if [ $? -ne 0 ]; then
	echo "$(date) Internet problem detected, restarting network-manager." >> $LOG_FILE
	service networking stop
	if [[ -f /var/run/wpa_supplicant/wlan0 ]]; then
		echo "Removing /var/run/wpa_supplicant/wlan0"
		rm -f /var/run/wpa_supplicant/wlan0
		wpa_supplicant -B -iwlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf
	fi

	service networking start
	dhclient wlan0
else
	echo "$(date) No problem detected." >> $LOG_FILE
fi

