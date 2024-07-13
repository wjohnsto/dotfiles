#!/bin/bash

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR=$(pwd)
COPY_CONFIG_FILE="$ROOT_DIR/copy.conf"

. $SCRIPT_DIR/utils.sh

create_copies() {
  check_config $COPY_CONFIG_FILE
  info "Copying files..."

    # Read dotfile files from the config file
    while IFS=: read -r source target || [ -n "$source" ]; do

        # Skip empty or invalid lines in the config file
        if [[ -z "$source" || -z "$target" || "$source" == \#* ]]; then
            continue
        fi

        # Evaluate variables
        source=$(eval echo "$source")
        target=$(eval echo "$target")

        # Check if the source file exists
        if [ ! -e "$source" ]; then
            error "Error: Source file '$source' not found. Skipping copy for '$target'."
            continue
        fi

        # Check if the symbolic link already exists
        if [ -f "$target" ]; then
            warn "File already exists: $target"
        else
            # Extract the directory portion of the target path
            target_dir=$(dirname "$target")

            # Check if the target directory exists, and if not, create it
            if [ ! -d "$target_dir" ]; then
                mkdir -p "$target_dir"
                info "Created directory: $target_dir"
            fi

            # Copy the file
            cp "$source" "$target"
            success "Copied $source to $target"
        fi
    done <"$COPY_CONFIG_FILE"
}

delete_copies() {
  check_config $COPY_CONFIG_FILE
    info "Deleting files..."

    while IFS=: read -r _ target || [ -n "$target" ]; do

        # Skip empty and invalid lines
        if [[ -z "$target" ]]; then
            continue
        fi

        # Evaluate variables
        target=$(eval echo "$target")

        # Check if the file exists
        if [ -L "$target" ] || [ -f "$target" ];  then
            # Remove the file
            rm -rf "$target"
            success "Deleted: $target"
        else
            warn "Not found: $target"
        fi
    done <"$COPY_CONFIG_FILE"
}

