#!/bin/bash
# Define the input video file
input="KDxJlW6cxRk.mp4"



# Define the output video file
output="output_video.mp4"

# Define the duration of each segment (in seconds)
segment_duration=2

# Define the start times for the segments you want to extract (in seconds)
# These values are hardcoded, but in a real scenario, you could generate them randomly
start_times=(10 30 50 70 90)

# Create the filter complex string
filter_complex=""
for start_time in "${start_times[@]}"; do
    filter_complex+="[0:v]trim=start=${start_time}:duration=${segment_duration},setpts=PTS-STARTPTS[seg${start_time}]; "
done

# Concatenate the segments
filter_complex+="[seg${start_times[0]}][seg${start_times[1]}][seg${start_times[2]}][seg${start_times[3]}][seg${start_times[4]}]concat=n=5:v=1:a=0[outv]"

# Execute the FFmpeg command
ffmpeg -i "$input" -filter_complex "$filter_complex" -map "[outv]" "$output"
