#!/bin/bash

echo "Upgrading repos"

cd ~/.fzf && git pull && ./install && cd -

./reset.sh

