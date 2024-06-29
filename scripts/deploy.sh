#!/bin/bash

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."

. $SCRIPT_DIR/utils.sh

deploy_dotfiles() {
  info "Deploying dotfiles..."

  cp -r $ROOT_DIR/home/ ~/
  cp -a $ROOT_DIR/home/. ~/
}

deploy_fonts() {
  info "Deploying fonts..."

  fc-cache -f ~/.fonts
}

deploy_nvim() {
  info "Deploying neovim config..."

  rm -rf ~/.config/nvim
  cp -r $ROOT_DIR/nvim ~/.config/
}

deploy() {
  deploy_dotfiles
  deploy_fonts
  deploy_nvim
}
