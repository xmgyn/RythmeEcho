#!/bin/bash

VIDEO_FILE="../Videos/$1.mp4"
AUDIO_FILE="../Videos/$1.m4a"
OUTPUT_DASH="../Videos/$1"

if [[ ! -f "$VIDEO_FILE" ]]; then
    echo "Error: Video file $VIDEO_FILE does not exist."
    exit 1
fi

if [[ ! -f "$AUDIO_FILE" ]]; then
    echo "Error: Audio file $AUDIO_FILE does not exist."
    exit 1
fi

if [[ -f "$OUTPUT_LOOP" ]]; then
    rm "$OUTPUT_LOOP"
fi

if [[ -d "$OUTPUT_DASH" ]]; then
    rm -r "$OUTPUT_DASH"
fi

if [[ ! -d "$OUTPUT_DASH" ]]; then
    mkdir -p "$OUTPUT_DASH"
fi

ffmpeg -i "$VIDEO_FILE" -i "$AUDIO_FILE" -c:v copy -c:a aac -strict -2 -map 0:v:0 -map 1:a:0 -use_timeline 1 -use_template 1 -seg_duration 10 -adaptation_sets "id=0,streams=v id=1,streams=a" -f dash "$OUTPUT_DASH/manifest.mpd"

echo "DASH Conversion completed."

rm "$VIDEO_FILE"
rm "$AUDIO_FILE"
