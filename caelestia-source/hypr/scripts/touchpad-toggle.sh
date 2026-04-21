#!/bin/bash
STATE_FILE="/tmp/touchpad_state"

if [ -f "$STATE_FILE" ] && [ "$(cat $STATE_FILE)" = "off" ]; then
    hyprctl keyword device[elan1201:00-04f3:3098-touchpad]:enabled true
    hyprctl keyword device[elan1201:00-04f3:3098-mouse]:enabled true
    echo "on" > $STATE_FILE
    notify-send "Touchpad" "Diaktifkan ✅"
else
    hyprctl keyword device[elan1201:00-04f3:3098-touchpad]:enabled false
    hyprctl keyword device[elan1201:00-04f3:3098-mouse]:enabled false
    echo "off" > $STATE_FILE
    notify-send "Touchpad" "Dinonaktifkan 🚫"
fi
