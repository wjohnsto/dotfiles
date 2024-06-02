#!/bin/sh

echo "Resetting configs..."

echo "Resetting neovim configuration..."

rm -rf ~/.local/share/nvim

./deploy.sh

echo "Done resetting!"