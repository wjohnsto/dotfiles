#!/bin/bash

default_color=$(tput sgr 0)
red="$(tput setaf 1)"
yellow="$(tput setaf 3)"
green="$(tput setaf 2)"
blue="$(tput setaf 4)"

ensure_dir() {
    [ ! -d $1 ] && mkdir $1
}

log() {
    printf "%s\n" "$1"
}

info() {
    printf "%s==> %s%s\n" "$blue" "$1" "$default_color"
}

success() {
    printf "%s==> %s%s\n" "$green" "$1" "$default_color"
}

error() {
    printf "%s==> %s%s\n" "$red" "$1" "$default_color"
}

warning() {
    printf "%s==> %s%s\n" "$yellow" "$1" "$default_color"
}

warn() {
    printf "%s==> %s%s\n" "$yellow" "$1" "$default_color"
}

check_quit() {
  if [ "$1" == "q" ]; then
    info "Quitting..."
    exit 1
  fi
}

check_config() {
    # Check if configuration file exists
    if [ ! -f "$0" ]; then
        warn "Configuration file not found: $0"
        exit 1
    fi
}

