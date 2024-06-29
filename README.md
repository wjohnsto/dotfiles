# dotfiles

This repository contains my personal dotfiles and tool configurations. It serves as a guide for quickly getting setup quickly with:

1. [wezterm](https://wezfurlong.org/wezterm/)
1. [starship](https://starship.rs/)
1. [neovim](https://neovim.io/)

## Overview

You can modify this repo however you want, but the general way it works is by using symlinks
(defined in `symlinks.conf`) into your $HOME directory. This way you can edit the configuration and
in some cases you won't need to redeploy.

## Instructions

You can run the following command:

```bash
./dot.sh
```

This will prompt you for what you want to do. It offers the following options:

1. `Initialize` - Guides you through installing the prerequisites and then deploys the configurations
1. `Deploy` - Resets symlinks and font cache
1. `Reset` - Resets some of the generated configuration/preferences and then deploys again
1. `Update` - If you choose to install some tools from source, use this to update the source and reinstall

