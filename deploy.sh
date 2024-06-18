#!/bin/bash

echo "Deploying configs..."

echo "Deploying home dotfiles..."

cp -r ./home/ ~/
cp -a ./home/. ~/

source ~/.bashrc

echo "Deploying fonts..."

fc-cache -f ~/.fonts

echo "Deploying neovim configuration..."

rm -rf ~/.config/nvim
cp -r ./nvim ~/.config/

echo "Done deploying!"

