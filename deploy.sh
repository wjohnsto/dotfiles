#!/bin/sh

echo "Deploying to production..."

echo "Deploying neovim configuration..."

rm -rf ~/.config/nvim
cp -r ./nvim ~/.config/

echo "Done!"

