#!/usr/bin/env bash
wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q "MUTED"; then
    pw-play --volume 0.5 ~/.local/share/sounds/micsounds/mute.wav
else
    pw-play --volume 0.5 ~/.local/share/sounds/micsounds/unmute.wav
fi
