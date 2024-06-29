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

  ensure_dir ~/.fonts/
  cp -a $ROOT_DIR/fonts/. ~/.fonts/
  fc-cache -f ~/.fonts
}

deploy_starship() {
  info "Deploying starship config..."

  ensure_dir ~/.config/
  cp -a $ROOT_DIR/starship/. ~/.config
}

deploy_wezterm() {
  info "Deploying wezterm config..."

  ensure_dir ~/.config/
  cp -r $ROOT_DIR/wezterm ~/.config/
}

deploy_nvim() {
  info "Deploying neovim config..."

  ensure_dir ~/.config/
  ensure_dir ~/.config/nvim
  rm -rf ~/.config/nvim
  cp -r $ROOT_DIR/nvim ~/.config/
}

deploy_final() {
  info "Finalizing deployment..."

  source ~/.bash_profile
}

deploy() {
  deploy_dotfiles
  deploy_fonts
  deploy_starship
  deploy_wezterm
  deploy_nvim
}
