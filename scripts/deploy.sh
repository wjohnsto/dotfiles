#!/bin/bash

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR=$(pwd)

. $SCRIPT_DIR/utils.sh
. $SCRIPT_DIR/symlinks.sh
. $SCRIPT_DIR/copy.sh

deploy() {
  delete_symlinks
  create_symlinks

  delete_copies
  create_copies

  info "Adding fonts..."
  fc-cache -f ~/.fonts

  info "Sourcing bash profile..."
  source ~/.bash_profile
}
