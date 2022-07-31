#! /usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit
killall -q polybar


# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do 
    sleep 1; 
done


# Launch polybar using default config location ~/.config/polybar/config
LOGFILE="/tmp/polybar.log"

echo "" | $LOGFILE
polybar 2>&1 | tee -a $LOGFILE & disown
