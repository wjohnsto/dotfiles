#!/bin/bash

echo $(pwd)

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."
CONFIG_FILE="$ROOT_DIR/symlinks.conf"

. $SCRIPT_DIR/utils.sh

# Check if configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
    warn "Symlink configuration file not found: $CONFIG_FILE"
    exit 1
fi

create_symlinks() {
    info "Creating symbolic links..."

    # Read dotfile links from the config file
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
            error "Error: Source file '$source' not found. Skipping link creation for '$target'."
            continue
        fi

        # Check if the symbolic link already exists
        if [ -L "$target" ]; then
            warn "Symbolic link already exists: $target"
        elif [ -f "$target" ]; then
            warn "File already exists: $target"
        else
            # Extract the directory portion of the target path
            target_dir=$(dirname "$target")

            # Check if the target directory exists, and if not, create it
            if [ ! -d "$target_dir" ]; then
                mkdir -p "$target_dir"
                info "Created directory: $target_dir"
            fi

            # Create the symbolic link
            ln -s "$source" "$target"
            success "Created symbolic link: $target"
        fi
    done <"$CONFIG_FILE"
}

delete_symlinks() {
    info "Deleting symbolic links..."

    while IFS=: read -r _ target || [ -n "$target" ]; do

        # Skip empty and invalid lines
        if [[ -z "$target" ]]; then
            continue
        fi

        # Evaluate variables
        target=$(eval echo "$target")

        # Check if the symbolic link or file exists
        if [ -L "$target" ] || [ -f "$target" ];  then
            # Remove the symbolic link or file
            rm -rf "$target"
            success "Deleted: $target"
        else
            warn "Not found: $target"
        fi
    done <"$CONFIG_FILE"
}

