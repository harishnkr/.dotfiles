#!/usr/bin/env bash

# Get all songs from MPD
song=$(mpc listall | wofi --dmenu --prompt "🎵 Play song:")

# If a song was chosen, clear queue, add it, and play
if [ -n "$song" ]; then
    mpc clear
    mpc add "$song"
    mpc play
fi

