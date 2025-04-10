#!/bin/bash

VIDEO_FILE="media/$1.mp4"
AUDIO_FILE="media/$1.m4a"
OUTPUT_LOOP=".loop/$1.mp4"
OUTPUT_DASH="media/$1"

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

segment_duration=2
start_times=() 
for ((i=0; i<5; i++)); do 
	start_times+=($(shuf -i 0-$((($2)-segment_duration)) -n 1)) 
done

filter_complex=""
for start_time in "${start_times[@]}"; do
    filter_complex+="[0:v]trim=start=${start_time}:duration=${segment_duration},setpts=PTS-STARTPTS[seg${start_time}]; "
done

filter_complex+="[seg${start_times[0]}][seg${start_times[1]}][seg${start_times[2]}][seg${start_times[3]}][seg${start_times[4]}]concat=n=5:v=1:a=0[outv]"

ffmpeg -i "$VIDEO_FILE" -filter_complex "$filter_complex" -map "[outv]" "$OUTPUT_LOOP"

echo "Loop Making Done."

ffmpeg -i "$VIDEO_FILE" -i "$AUDIO_FILE" -c:v copy -c:a aac -strict -2 -map 0:v:0 -map 1:a:0 -use_timeline 1 -use_template 1 -seg_duration 10 -adaptation_sets "id=0,streams=v id=1,streams=a" -f dash "$OUTPUT_DASH/manifest.mpd"

echo "DASH Conversion completed."

rm "$VIDEO_FILE"
rm "$AUDIO_FILE"
