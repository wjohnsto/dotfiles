#!/bin/bash

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR=$(pwd)

. $SCRIPT_DIR/utils.sh

update_fzf() {
  info "Updating fzf..."

  cd ~/.fzf && git pull && ./install && cd -
}

update() {
  update_fzf
}

