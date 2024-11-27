#!/bin/bash

set -x  # Enable debugging
shopt -s globstar

source_dir="/Users/cullenmacdonald/Documents/cullen"
target_dir="/Users/cullenmacdonald/dev/blog/content"

echo "Source Directory: $source_dir"
echo "Target Directory: $target_dir"

# Empty target dir to handle unpublishing
find $target_dir ! -name 'index.md' -type f -exec rm -f {} +

# Find markdown files containing #blog-publish and copy them
find "$source_dir" -type f -name "*.md" -exec grep -l "#blog/publish" {} \; | while read -r file; do
    line_count=$(wc -l < "$file")
    lines_to_keep=$((line_count - 5 - 2))
    output_file="$target_dir/$(basename "$file")"
    tail -n +3 "$file" | head -n "$lines_to_keep" > "$output_file"
    echo "Copied $file to $target_dir"
done
