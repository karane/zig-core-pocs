#!/bin/bash

# Check if a parameter is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <zig_filename_without_extension>"
    exit 1
fi

# Get the filename without extension
FILE_NAME="$1"
ZIG_FILE="$FILE_NAME.zig"
OUTPUT="./tmp/$FILE_NAME"

# Compile the Zig program
echo "Compiling $ZIG_FILE to $OUTPUT..."
zig build-exe "$ZIG_FILE" -femit-bin="$OUTPUT"

# Check if compilation was successful
if [ $? -eq 0 ]; then
    echo "Compilation successful. Running $OUTPUT..."
    "$OUTPUT"
else
    echo "Compilation failed."
    exit 1
fi
