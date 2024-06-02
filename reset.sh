#!/bin/sh

echo "Resetting configs..."

echo "Resetting neovim configuration..."

rm -rf ~/.local/share/nvim

echo "Done resetting!"

./deploy.sh
