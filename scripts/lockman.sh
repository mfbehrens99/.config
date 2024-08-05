#!/bin/sh
# Times the screen off and puts it to background
loginctl lock-session
swayidle \
    timeout 10 'swaymsg "output * dpms off"' \
    resume 'swaymsg "output * dpms on"' &
# Locks the screen immediately
sleep 1 && swaylock -f -c 000000
# Kills last background task so idle timer doesn't keep running
kill %%