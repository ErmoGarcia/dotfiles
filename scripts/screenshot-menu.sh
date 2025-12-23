#!/usr/bin/env bash

DIR_PICTURES="$HOME/Pictures/Screenshots"
DIR_VIDEOS="$HOME/Videos/Screencasts"

mkdir -p "$DIR_PICTURES" "$DIR_VIDEOS"

# Get sway outputs
OUTPUT1=$(swaymsg -t get_outputs -r | jq -r '.[] | select(.active==true) | .name' | sed -n '1p')
OUTPUT2=$(swaymsg -t get_outputs -r | jq -r '.[] | select(.active==true) | .name' | sed -n '2p')

if pgrep -x wf-recorder > /dev/null; then
    pkill -SIGINT wf-recorder
    notify-send -t 10000 "Video recording stopped..."
    exit 0
fi

chosen=$(printf "Screenshot: Full screen\nScreenshot: Selection\nRecord: Full screen\nRecord: Selection" | \
    fuzzel --dmenu --prompt="Screenshot: ")

timestamp=$(date +%F-%H%M%S)

case "$chosen" in
    "Screenshot: Full screen")
        grim "$DIR_PICTURES/screenshot-$timestamp.png"
        ;;
    "Screenshot: Selection")
        grim -g "$(slurp)" "$DIR_PICTURES/screenshot-$timestamp.png"
        ;;
    "Record: Full screen")
        monitor=$(printf "$OUTPUT1\n$OUTPUT2" | \
            fuzzel --dmenu --prompt="Monitor: ")
        [ -n "$monitor" ] && wf-recorder -o "$monitor" -f "$DIR_VIDEOS/recording-$timestamp.mp4" & disown
        ;;
    "Record: Selection")
        wf-recorder -g "$(slurp)" -f "$DIR_VIDEOS/recording-$timestamp.mp4" & disown
        ;;
esac

