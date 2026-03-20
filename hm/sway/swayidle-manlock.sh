#!/usr/bin/env bash

swayidle \
    timeout 1 'swaymsg "output * power off"' \
    resume 'swaymsg "output * power on"' &
IDLE_PID=$!
swaylock -f
kill $IDLE_PID
