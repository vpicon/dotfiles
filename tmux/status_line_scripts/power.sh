#!/usr/bin/bash

battery_dev="/sys/class/power_supply/BAT1"

echo  "$(expr $(( $(cat $battery_dev"/charge_now") * 100 ))  / $(cat $battery_dev"/charge_full") )""%"


