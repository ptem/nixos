#!/usr/bin/env bash

# adapted from "https://github.com/Alexays/Waybar/wiki/Module:-Image"
status=$(playerctl -p Feishin status 2>/dev/null)
exit_code=$?


if [[ $exit_code -ne 0 || "$status" == "Stopped" ]]; then
    echo "/tmp/nothing.jpeg"
    exit 0
fi

art_url=$(playerctl -p Feishin metadata mpris:artUrl 2>/dev/null)

if [[ -n "$art_url" ]]; then
    clean_url="${art_url#file://}"

    if [[ "$art_url" == http* ]]; then
        curl -s "$art_url" --output "/tmp/cover.jpeg"
        echo "/tmp/cover.jpeg"
    else
        echo "$clean_url"
    fi
fi
