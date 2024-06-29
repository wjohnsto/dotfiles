
#!/bin/bash

# Get the absolute path of the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR=$(pwd)
INIT_CONFIG_FILE="$ROOT_DIR/prerequisites.conf"

. $SCRIPT_DIR/utils.sh

prompt_install() {
  read -p "Install $1 ($2). [C/q]> " installed < /dev/tty

  check_quit $installed
}

initialize() {
  check_config $INIT_CONFIG_FILE
  info "Installing initial prerequisites..."

  while IFS=: read -r tool url || [ -n "$tool" ]; do

    if [[ -z "$tool" || "$tool" == \#* ]]; then
      continue
    fi

    prompt_install $tool $url

  done <"$INIT_CONFIG_FILE"
}

