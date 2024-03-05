#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_image> <output_image>"
    exit 1
fi

input_image="$1"
output_image="$2"
width=550
height=550

# Resize the image while maintaining the aspect ratio
convert "$input_image" -resize "x$height" -gravity center -crop "${width}x$height+0+0" +repage -extent "${width}x$height" "$output_image"
