#!/bin/bash
# Low battery notifier

# Kill already running processes
already_running="$(ps -fC 'grep' -N | grep 'battery.sh' | wc -l)"
if [[ $already_running -gt 1 ]]; then
	pkill -f --older 1 'battery.sh'
fi

# Get path
path="$( dirname "$(readlink -f "$0")" )"

while [[ 0 -eq 0 ]]; do
	battery_status="$(cat /sys/class/power_supply/BAT0/status)"
	battery_charge="$(cat /sys/class/power_supply/BAT0/capacity)"

	if [[ $battery_status == 'Discharging' && $battery_charge -le 25 ]]; then
		if   [[ $battery_charge -le 15 ]]; then
			notify-send -t 10000 --icon="$path/battery_critical.svg" --urgency=critical "Battery critical!" "${battery_charge}%"
			sleep 60
		else
			notify-send -t 10000 --icon="$path/battery_low.svg" "Battery low!" "${battery_charge}%"
			sleep 120
		fi
	else
		sleep 600
	fi
done
