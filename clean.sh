#!/bin/bash

# Ensure the script is run from the directory it is located in
if [ "$(dirname "$0")" != "." ]; then
    echo "🦘 Please run this script from its containing directory."
    exit 1
fi

# Function to remove a directory if it contains symbolic links or is empty
remove_directory_if_needed() {
    local dir=$1
    local symlink_count
    local file_count

    # Check if the directory contains any symbolic links
    symlink_count=$(find "$dir" -maxdepth 1 -type l | wc -l)
    # Check if the directory is empty
    file_count=$(find "$dir" -mindepth 1 | wc -l)

    if [ "$symlink_count" -gt 0 ] || [ "$file_count" -eq 0 ]; then
        rm -rf "$dir"
        echo "✅ Removed directory: $dir"
    else
        echo "🦘 Directory $dir does not need to be removed. Skipping."
    fi
}

# Get a list of directories in the current directory
directories=$(find . -maxdepth 1 -type d ! -path .)

# Remove directories that contain symbolic links or are empty
for dir in $directories; do
    remove_directory_if_needed "$dir"
done

echo "Clean up completed successfully."
