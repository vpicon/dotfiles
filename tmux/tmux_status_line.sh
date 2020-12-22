#!/usr/bin/bash

SCRIPT_DIR="$HOME/.dotfiles/tmux"
STATUS_LINE=

# Add current laptop battery song if possible
CURRENT_POWER=$($SCRIPT_DIR/status_line_scripts/power.sh 2>&1 )
if [ $? -eq 0 ]; then
    STATUS_LINE="$CURRENT_POWER"" | $STATUS_LINE"
fi

# Add current spotify song if possible
CURRENT_SONG=$($SCRIPT_DIR/status_line_scripts/spotify_metadata.py 2>&1 )
if [ $? -eq 0 ]; then
    STATUS_LINE='♫ '"$CURRENT_SONG"" | $STATUS_LINE"
fi

echo "$STATUS_LINE"
