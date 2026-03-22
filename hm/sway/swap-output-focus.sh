#!/usr/bin/env bash

# Script by Bruitosaure on https://github.com/swaywm/sway/issues/8799

# Sway screen names
SCREEN1="DP-1"
SCREEN2="DP-2"

# Get the output where the active workspace is located
CURRENT_OUT=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true) | .output')

# Safety check if no output found
if [ -z "$CURRENT_OUT" ] || [ "$CURRENT_OUT" = "null" ]; then
    exit 0
fi

if [ "$CURRENT_OUT" = "$SCREEN1" ]; then
    TARGET_OUT="$SCREEN2"
else
    TARGET_OUT="$SCREEN1"
fi

swaymsg focus output $TARGET_OUT
