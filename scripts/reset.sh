#!/bin/bash

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR=$(pwd)

. $SCRIPT_DIR/utils.sh

reset_nvim() {
  info "Resetting neovim config..."

  rm -rf ~/.local/share/nvim
}

reset() {
  reset_nvim
}

