#!/bin/bash

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."

. $SCRIPT_DIR/utils.sh
. $SCRIPT_DIR/symlinks.sh

deploy() {
  delete_symlinks
  create_symlinks

  info "Adding fonts..."
  fc-cache -f ~/.fonts

  info "Sourcing bash profile..."
  source ~/.bash_profile
}
