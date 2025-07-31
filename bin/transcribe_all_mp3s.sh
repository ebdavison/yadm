#!/bin/bash

# Ensure whisper-cli is in your PATH or adjust this variable
WHISPER_CLI=whisper

whisper env activate

# Loop over all .mp3 files
find . -maxdepth 1 -type f -name "*.mp3" -print0 | while IFS= read -r -d '' file; do
    # Get base name without extension
    base="$(basename "$file" .mp3)"
    # Output file
    out="${base}.txt"
    echo "Transcribing: $file -> $out"
    # "$WHISPER_CLI" "$file" --output_format txt --output_file "$out"
    "$WHISPER_CLI" transcribe "$file" > "$out"
done
