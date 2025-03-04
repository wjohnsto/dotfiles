# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

### PATHs

# java
export JAVA_HOME="/usr"

# sqlcmd and bcp
export PATH="$PATH:/opt/mssql-tools18/bin"

# fzf
if [[ ! "$PATH" == */$HOME/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

# Neovim
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export VIM="/opt/nvim-linux-x86_64/share/nvim"
export VIMRUNTIME="/opt/nvim-linux-x86_64/share/nvim/runtime"

# Go
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/go/bin"

# Node
export PATH="$PATH:~/.npm-global/bin"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# NVM
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# fly.io
export FLYCTL_INSTALL="$HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

### Global vars
export VISUAL=nvim
export EDITOR="$VISUAL"
export INPUTRC=~/.inputrc
export GIT_PROJECT_HOME=~/src

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	    . "$HOME/.bashrc"
    fi
fi


### Environments

# Cargo
. "$HOME/.cargo/env"

# fzf
eval "$(fzf --bash)"
# [ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Starship
eval "$(starship init bash)"

# fnm
eval "$(fnm env --use-on-cd --shell bash)"

# Wezterm
. "$HOME/.config/wezterm/wezterm.sh"

# pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/wjohnsto/.local/bin/google-cloud-sdk/path.bash.inc' ]; then . '/home/wjohnsto/.local/bin/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/wjohnsto/.local/bin/google-cloud-sdk/completion.bash.inc' ]; then . '/home/wjohnsto/.local/bin/google-cloud-sdk/completion.bash.inc'; fi
