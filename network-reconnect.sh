#!/usr/bin/env bash
set -e

ping -c 3 -W 10 8.8.8.8 >/dev/null

if [ $? -ne 0 ]; then
	echo "$(date) Internet problem detected, restarting network connection."
	service networking stop
	service networking start
	dhclient -r
	iwconfig wlan0 essit "Green Dragon Free WiFi"
	dhclient wlan0
else
	echo "$(date) No problem detected."
fi

