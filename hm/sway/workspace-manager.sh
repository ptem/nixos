#!/usr/bin/env bash

# Script to manage workspaces in a dual-monitor setup.
# - Target workspaces on currently focused monitor or other monitor via -s flag (i.e. is swappy)
# - Move focused window to target workspace with -m flag
# - Shift focus from currently focused workspace to target workspace with -f flag.
# - can combine, e.g.:
#   - ./workspace-manager.sh -w 3 -smf` moves the currently focused window to the 3rd workspace on the opposite monitor, and shifts the focus to that workspace.

# PREAMBLE
# This script assumes a particular workspace structure, though can be modified to suit others.
# Monitor 1: Workspaces 1-1, 1-2, ..., 1-n
# Monitor 2: Workspaces 2-1, 2-2, ..., 2-n
# I personally max at n=5 on a given monitor and rarely use more than a couple per monitor anyway.
#
# In your sway config, define outputs and workspaces:
# set $outOne DP-1
# set $outTwo DP-2
# `workspace "1-1" output $outOne` through `workspace "1-5" output $outOne`
# `workspace "2-1" output $outTwo` through `workspace "2-5" output $outTwo`
#
# Set OUT1/OUT2 to your outputs (same as outOne and outTwo). currently the script only uses the former.
# If your outputs aren't named DP-#, you will need to slightly modify the script. I did this mostly for convenience.
OUT1="DP-1"
OUT1_ID="1"

OUT2="DP-2"
OUT2_ID="2"

# USAGE
# ./workspace-manager.sh -w <number> [-s] {-m|-f|-mf}
# -w <n>: Target the nth workspace.
# -s: if specified, target the monitor that is NOT currently focused.
# -m: if specified, move the currently focused window to target workspace number on target monitor.
# -f: if specified, focus target workspace number on target monitor.

###############################################################################


WORKSPACE_NUM=""
SWAPPY="0"
MOVESPACE="0"
FOCUS="0"

while getopts w:smf flag; do
    case "${flag}" in
        w) WORKSPACE_NUM=${OPTARG} ;;
        s) SWAPPY="1" ;;
        m) MOVESPACE="1" ;;
        f) FOCUS="1" ;;
        *) echo "Usage: $0 -w <number> [-s] {-m|-f|-mf}"
           exit 1 ;;
    esac
done

if [ "$MOVESPACE" -eq 0 ] && [ "$FOCUS" -eq 0 ]; then
    echo "ERROR: At least one of MOVE WORKSPACE or FOCUS WORKSPACE (-m/-f) is required."
    exit 1
fi

if [ -z "$WORKSPACE_NUM" ]; then
    echo "ERROR: A workspace must be targeted with -w [workspace number]"
    exit 1
fi

if [ "$SWAPPY" -eq 1 ]; then
    echo "Targeting workspace $WORKSPACE_NUM on opposite monitor."
else
    echo "Targeting workspace $WORKSPACE_NUM on same monitor."
fi

if [ "$MOVESPACE" -eq 1 ]; then
    echo "Moving focused window to targeted workspace."
fi

if [ "$FOCUS" -eq 1 ]; then
    echo "Focusing targeted workspace."
fi


# TARGET_OUT=""
TARGET_OUT_ID=""

# Get the currently focused output
CURRENT_OUT=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true) | .output')

# In case no output...
if [ -z "$CURRENT_OUT" ] || [ "$CURRENT_OUT" = "null" ]; then
    exit 0
fi

if [ "$CURRENT_OUT" = "$OUT1" ]; then
    if [ "$SWAPPY" -eq 1 ]; then
        # TARGET_OUT="$OUT2"
        TARGET_OUT_ID="$OUT2_ID"
    else
        # TARGET_OUT="$OUT1"
        TARGET_OUT_ID="$OUT1_ID"
    fi
else
    if [ "$SWAPPY" -eq 1 ]; then
        # TARGET_OUT="$OUT1"
        TARGET_OUT_ID="$OUT1_ID"
    else
        # TARGET_OUT="$OUT2"
        TARGET_OUT_ID="$OUT2_ID"
    fi
fi


if [ "$MOVESPACE" -eq 1 ]; then
    # move container
    swaymsg move container to workspace "$TARGET_OUT_ID-$WORKSPACE_NUM"
fi

if [ "$FOCUS" -eq 1 ]; then
    # shift focus to target workspace
    swaymsg workspace "$TARGET_OUT_ID-$WORKSPACE_NUM"
fi


# woag
