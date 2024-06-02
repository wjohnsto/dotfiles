#!/bin/sh

echo "Deploying configs..."

echo "Deploying home dotfiles..."

cp -r ./home/ ~/

source ~/.bashrc

echo "Deploying neovim configuration..."

rm -rf ~/.config/nvim
cp -r ./nvim ~/.config/

echo "Done deploying!"

