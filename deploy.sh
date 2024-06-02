#!/bin/bash

echo "Deploying configs..."

echo "Deploying home dotfiles..."

cp -r ./home/ ~/

source ~/.bashrc

echo "Deploying fonts..."

cp -r ./.fonts/ ~/.fonts/

fc-cache -f ~/.fonts

echo "Deploying neovim configuration..."

rm -rf ~/.config/nvim
cp -r ./nvim ~/.config/

echo "Done deploying!"

